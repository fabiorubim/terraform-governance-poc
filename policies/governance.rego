
package terraform.governance

import rego.v1

deny contains msg if {
    some rc in input.resource_changes

    rc.type == "terraform_data"

    rc.change.after.input.encrypted == false

    msg := sprintf(
        "Recurso %s: criptografia obrigatoria",
        [rc.address]
    )
}

# Bloqueia buckets S3 sem criptografia declarada
deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_s3_bucket"

    not encryption_configured(rc.address)

    msg := sprintf("Bucket %s: criptografia obrigatoria", [rc.address])
}

encryption_configured(bucket_address) if {
    some rc in input.resource_changes

    rc.type == "aws_s3_bucket_server_side_encryption_configuration"
    rc.change.actions != ["delete"]

    rc.change.after.rule[_].apply_server_side_encryption_by_default[_].sse_algorithm == "AES256"
}

# Bloqueia configurações que não habilitam todas as proteções de acesso público
deny contains msg if {
    some rc in input.resource_changes

    rc.type == "aws_s3_bucket_public_access_block"
    rc.change.after != null

    not all_public_access_blocked(rc.change.after)

    msg := sprintf("Recurso %s: bloqueio de acesso publico obrigatorio", [rc.address])
}

all_public_access_blocked(config) if {
    config.block_public_acls == true
    config.block_public_policy == true
    config.ignore_public_acls == true
    config.restrict_public_buckets == true
}