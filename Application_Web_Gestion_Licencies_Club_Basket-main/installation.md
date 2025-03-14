
# Project Installation with Docker

This project uses **Docker** and **Docker Compose** to simplify the setup and running of the frontend and backend services in an isolated environment. By using Docker, you don't need to manually install system dependencies like Python, Node.js, or MySQL. Docker takes care of everything for you.

## Prerequisites

Before getting started, make sure you have Docker and Docker Compose installed on your machine.

1. **Docker**: You can check if Docker is installed by running the following command:

   ```bash
   docker --version
   ```

   If Docker is not installed, follow the official Docker installation guide: [Install Docker](https://docs.docker.com/get-docker/).

2. **Docker Compose**: You can check if Docker Compose is installed by running:

   ```bash
   docker-compose --version
   ```
   or
   ```bash
   docker compose --version
   ```

   If Docker Compose is not installed, follow the official Docker Compose installation guide: [Install Docker Compose](https://docs.docker.com/compose/install/).

## Running the Project with Docker

The project consists of two main services: a frontend (Vue.js) and a backend (FastAPI), as well as a MySQL database. You can run these services using Docker and Docker Compose.

### 1. **Run the Complete App with Docker Compose**

The `docker-compose.yml` file defines the services needed for the project. It includes configurations for the frontend, backend, and database.

#### Run All Services with Docker Compose

From the root of your project, run the following command to start all the services defined in the `docker-compose.yml` file:

```bash
docker-compose up --build
```
or
```bash
docker compose up --build
```

This will build the images and start the containers for the frontend, backend, and database.

- The **frontend** will be accessible at `http://localhost:5173`.
- The **backend** will be accessible at `http://localhost:8000`.
- The **MySQL database** is accessible inside the Docker network but not exposed directly to the host machine.

#### Stop and Remove Containers

Once you're done, you can stop and remove the containers with the following command:

```bash
docker-compose down
```

This will stop and remove the containers but keep the images for the next time you run them.

### 2. **Run the Frontend Separately**

If you'd like to start only the frontend, you can do so using Docker. Here's how to do it.

#### Build the Frontend Image

Run the following command from the root of your project to build the frontend image:

```bash
docker build -t my-frontend -f frontend/Basketballapp/Dockerfile.frontend .
```

#### Run the Frontend

Once the image is built, you can start the frontend container with this command:

```bash
pip install fastapi uvicorn
```

### 2. **Install databases, sqlalchemy, python-dotenv, aiomysql & asyncmy**

Install databases and SQLAlchemy to interact with the database:

```bash
pip install databases sqlalchemy python-dotenv asyncmy aiomysql
```

### 3. **Setting up environment variables**

Create an `.env` file in the root directory of your project :

````bash
DB_USER=[your_db_user]
DB_PASSWORD=[your_db_password]
DB_HOST=localhost
DB_NAME=[your_db_name]
DB_PORT=3306
````



### 4. **Launch FastAPI**

To start the server, run the following command:

```bash
pip install -r backend/requirements.txt
```

## Managing Linting and Code Quality

To ensure code consistency and quality, both the frontend and backend have linters configured.

### 1. **Backend Linter (Flake8)**

Flake8 is a Python linter used to enforce coding standards and style checks for the backend.

#### Install Flake8

Run the following command to install Flake8 in the backend:

```bash
cd backend/
pip install flake8
```

#### Run Flake8

To run Flake8 on your backend codebase, you can use the following command:

```bash
flake8 main.py
```

This will check for any style violations or issues in `main.py`. You can also run it on your entire backend directory.

### 2. **Frontend Linter (Prettier & ESLint)**

For the frontend, Prettier and ESLint are configured to ensure that the code is formatted correctly and adheres to a consistent style.

#### Install Prettier and ESLint

Run the following command to install Prettier and ESLint for the frontend:

```bash
cd frontend/Basketballapp
npm install --save-dev prettier eslint-plugin-prettier eslint-config-prettier
```

#### Configure Prettier and ESLint in Visual Studio Code

To enable Prettier and ESLint in Visual Studio Code, add the following settings in your `settings.json`:

```json
"editor.defaultFormatter": "esbenp.prettier-vscode",
"[vue]": {
   "editor.defaultFormatter": "esbenp.prettier-vscode"
},
"editor.formatOnSave": true,
```

#### Manually Format Code with Prettier

To manually format your code with Prettier, you can run the following command:

```ba