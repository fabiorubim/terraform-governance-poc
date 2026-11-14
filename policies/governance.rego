
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