# ReflexionAPI

Powershell module to interact with Reflexion's RESTful API: [api.reflexion.net/rfx-rest-api]

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Documentation](#documentation)

## Overview

Per Reflexion documentation all API calls must be authenticated by passing the following values to the headers:
- service_key  : { API_USER_SERVICE_KEY }
- auth_token   : { AUTH_TOKEN }
- content-type : application/json
- accept       : application/json

The auth token is generated using the ConnectTo-Reflexion function which requires the username, password, and 
API service key of the API management account.

## Requirements
To use this module the following Reflexion items are required:
- A user account with privilege to manage enterprises/users in Reflexion
- Adding that account as an API User and generating a service key.

### Documentation
For more info see the Reflexion API documentation: [https://s3.amazonaws.com/net-reflexion-marketing-videos/API.1.2.pdf]
