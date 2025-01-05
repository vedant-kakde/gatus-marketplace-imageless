# Publishing an Imageless App on Vultr Marketplace

This guide outlines the process of creating and publishing an imageless application on the Vultr Marketplace.

## Project Structure

```
gatus-marketplace-packer/
├── README.md
├── script/install.sh
└── vendor-data.json
```

## Configuration Files

**1. Vendor Data (vendor-data.json)**
This data is required for filling your app details in Marketplace

**2. Setup Script (install.sh)**
This script runs for deploying the app

## Marketplace Integration

### Required Files for Submission

1. **General Information:**
   - App Name, App Name ID Format
   - Repo URL
   - Operating System
   - Category

2. **Screenshots/Images:**
   - App icon Small (At least 88px height, max width of 186px)
   - Appp icon Large (At least 236px height, at least 236px width)
   - Product screenshot(s) (minimum 1280x720px)

3. **Documentation:**
   - Installation guide
   - Usage instructions
   - Configuration options
   - Troubleshooting steps

### App Variables
App variables are used to deploy and configure the application.
   - `gatus_username`: Username for accessing the Gatus dashboard.
   - `gatus_password`: Password for accessing the Gatus dashboard.
   - `monitoring_url`: The URL of the service you want to monitor (e.g., `https://www.google.com`).
   - `monitoring_int`: The interval between monitoring checks (e.g., `30s`, `1m`, `5m`).

## Marketplace App creation process

1. Create a Vultr account if you haven't already

2. Go to Marketplace and Create New App

![image](https://github.com/user-attachments/assets/56cc7c8a-8eef-4875-89a1-3f478ed944b1)

3. Fill in details and documentation of your app

![image](https://github.com/user-attachments/assets/008b5a0d-a212-4472-8894-416eaf9be1e6)

4. Add App variables

![image](https://github.com/user-attachments/assets/0f18dbcf-5361-4af2-a508-85dcdd3e3572)

5. Submit a App Instruction guide for the information page of the application

![image](https://github.com/user-attachments/assets/a0e4685b-1ed6-4298-b7eb-7326fe869318)

6. Go to Builds and Select Build From Vendor Data

![image](https://github.com/user-attachments/assets/06def9f3-9920-490b-8158-59426e5be8dd)

7. Now select OS: Ubuntu 20.04 and add your script here. Click on Build App Image.

![image](https://github.com/user-attachments/assets/76a14d0b-d4ee-4cc5-9b58-5bf30fc06022)

9. Now deploy the app

![image](https://github.com/user-attachments/assets/e7a68936-487b-4c96-9f53-40fdfea30666)

10. Fill requested details to deploy the app (User-supplied Variables - Required and Server hostnmae & Label - Optional)

![image](https://github.com/user-attachments/assets/0f046213-9684-432c-b73a-182972bc37b4)

![image](https://github.com/user-attachments/assets/c6d0391f-bc42-48b1-94dc-ece9123071df)

11. Click on Deploy Now

![image](https://github.com/user-attachments/assets/ea128636-7f4c-4961-884f-73c0e35b149e)

12. It will take some time to get the instance running

![image](https://github.com/user-attachments/assets/20407f40-88fa-4cd9-b7c7-9ab81f1b0aad)

Now click on View in Console

![image](https://github.com/user-attachments/assets/1d5ea5eb-2f2a-40e0-adee-5cdc2c873642)

13. Now, you can see the url to access your app

![image](https://github.com/user-attachments/assets/64ce6c5a-207d-4372-a642-5cc27dc6d6e8)

![image](https://github.com/user-attachments/assets/83f717c5-ba6b-4403-bdd2-153df899fe51)

![image](https://github.com/user-attachments/assets/63d601d7-7e5c-4302-92f1-4fda4905f77a)

14. Your application is deployed!

15. Now, if you want to re-configure the application:

You can find the config file here: /gatus-config/config.yaml

![image](https://github.com/user-attachments/assets/a507e2a7-d267-4fbc-858e-7bd3f5ab1841)

Update this config file according to your requirement and then stop the container and re-run
```bash
docker stop gatus
docker rm gatus
docker run -d --name gatus \
    -v "/gatus-config/config.yaml:/config/config.yaml" \
    -p 8080:8080 \
    --restart always \
    twinproduction/gatus
```

