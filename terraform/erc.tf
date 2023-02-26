#####################################################################################
#                              aws_ecrpublic_repository
#####################################################################################

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_ecrpublic_repository" "foo" {
  provider = aws.us_east_1

  repository_name = "pets-clinic"

  catalog_data {
    about_text        = "About Text"
    architectures     = ["ARM"]
    description       = "Description"
    operating_systems = ["Linux"]
    usage_text        = "pets-clinic"
  }

  tags = {
    env = "production"
  }
}
