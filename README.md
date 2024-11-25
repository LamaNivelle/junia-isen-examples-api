# Cloud Computing Project

## Acknowledgments

A big thanks to SKRZYPCZAK's team for helping us out with the CI/CD pipeline and to FyDXVI's team for helping on connecting the Blob Storage to the App Service and on the /example route. Your support made a huge difference—thank you !

## Project description

This project focuses on deploying the existing HTTP API ([fhuitelec/junia-isen-examples-api](https://github.com/fhuitelec/junia-isen-examples-api)) to Azure. It involves provisioning the necessary infrastructure, including Azure App Service, Azure Database, Azure Blob Storage, and other relevant resources such as virtual networks and IAM. The project also sets up a CI/CD pipeline using GitHub Actions to automate testing and deployment. Tests will run on each pull request, and when a pull request is merged into the `main` branch, the pipeline will build and publish a Docker image and deploy it to the App Service.

## Project structure

This project includes several key components: a **`/infrastructure/`** folder with all the necessary modules for provisioning cloud resources, a **`/.github/`** folder containing the code for the CI/CD pipeline, a **`/examples/`** folder with the API, and a **`/test/`** folder to ensure smooth functionality and development with every modification. Together, these elements streamline the deployment and management of the API on Azure.

## Team

- **Allan Ross**
- **Hector de Tocqueville**

# Installation

## Requirements

- HashiCorp Terraform `v1.5.7+` : https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Azure CLI `v2.66+` : https://learn.microsoft.com/fr-fr/cli/azure/install-azure-cli

### GitHub token

1. Open your browser and go to GitHub.
2. Log in to your GitHub account.
3. Click on your avatar in the upper-right corner of the page.
4. Select Settings from the dropdown menu.
5. In the left sidebar, scroll down and click on Developer settings.
6. Under Developer settings, select Personal access tokens.
7. Click on the Fine-grained tokens button in the menu.
8. Click on Generate new token.
9. Token name: Give the token a name, for example: CI/CD Integration Token.
10. Expiration: Select No expiration.
11. Repository: In the Select repositories section, choose the repository you just cloned.
12. Check the following permissions:
 * Actions: Read-only
 * Contents: Read-only
 * Deployments: Read-only
 * Metadata: Read-only
13. Once you’ve configured the permissions, click on Generate token.
14. GitHub will display your token only once. Copy it and save it (to be filled later in the docker_registry_password field of the terraform.tfvars.changeme file).

## Start the project

- Clone the repository on your local machine
- Open the folder `./infrastructure` in an IDE like VSCode
- Select the file "terraform.tfvars.changeme" and edit the values with your own environnement variables, then remove the ".changeme" extension
- In the same folder, open a terminal and run in this order `terraform init`, `terraform plan`, and finally `terraform apply`
- To access the web app, run the following command : `terraform state show module.app_service.azurerm_linux_web_app.web_app | grep "default_hostname"`. This will display the address to access the web app, you can now navigate through the /quotes or /examples routes.

## Architecture schema

<img src="/infra.png" alt="infrastructure architecture" width="200" />