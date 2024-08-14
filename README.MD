# EndeavourOS Docker Image

This repository contains a Docker setup for creating and managing an EndeavourOS-based Docker image. The `Makefile` provided automates the build process, container management, and cleanup tasks.

## Table of Contents

- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
  - [Building the Docker Image](#building-the-docker-image)
  - [Running the Docker Container](#running-the-docker-container)
  - [Cleaning Up](#cleaning-up)
  - [Other Commands](#other-commands)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

This project sets up an EndeavourOS environment within a Docker container. It uses a `Makefile` to streamline the process of building, running, and managing the Docker image.

## Prerequisites

Before using this project, ensure you have the following installed:

- Docker
- Make (GNU Make)
- Git (optional, for cloning the repository)

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/alex5402/endeavouros-docker.git
   cd endeavouros-docker
   ```

2. **Set Up the Docker Environment:**

   The provided `Makefile` will handle the setup, build, and management of the Docker image.

## Usage

### Building the Docker Image

To build the Docker image, use the following command:

```bash
make build
```

This will create a Docker image named `endeavouros:latest`.

### Running the Docker Container

To run the Docker container interactively, use:

```bash
make run
```

This command starts a container from the `endeavouros:latest` image.

### Cleaning Up

To remove intermediate images and containers, run:

```bash
make clean
```

### Other Commands

- **Remove Docker Image:**

  ```bash
  make remove
  ```

- **List Docker Images:**

  ```bash
  make images
  ```

- **List Docker Containers:**

  ```bash
  make ps
  ```

- **Stop All Running Containers:**

  ```bash
  make stop
  ```

- **Remove All Stopped Containers:**

  ```bash
  make remove-containers
  ```

## Contributing

Contributions are welcome! If you have suggestions or improvements, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---
