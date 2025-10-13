# Hash Gone Good

**B.Tech Final Year Thesis Project**  
**NIT Calicut, 2024-25**

**Authors:** Arun Natarajan, Hafeez Muhammed  
**Advisor:** Dr. Vinod Pathari

## Overview

This project extends the work from "Hash Gone Bad" (USENIX Security'23), focusing on the ProVerif implementation of computation functions for modeling hash function weaknesses in cryptographic protocol verification.

## Goals

- Analyze the ProVerif-side implementation of computation functions
- Study hash modeling techniques in symbolic verification
- Propose improvements to the existing framework
- Explore additional hash-based protocol vulnerabilities

## Quick Start

### Using Docker

#### Using Docker

Pull the image:

```
docker pull arunnats2004/proverif-compfun:latest
```

Run an interactive container:

```
docker run -it arunnats2004/proverif-compfun:latest
```

Verify the installation:

```
proverif --help
```

#### Running Case Studies

Inside the container, navigate to the case studies directory and run a specific model. For example:

```
cd ~/Proverif-Case-Studies/boundedAssoc
make ike_s=1 m4="-D noFlat -D noCol"
```

## Repository Structure

```
├── Docker/                 # Docker build files
├── Proverif-Case-Studies/  # Original case studies from the paper
├── proverif-compfun/       # Modified ProVerif source code
├── diff-check/             # Analysis of source code changes
└── README.md
```

## Resources

- **Docker Image:** [arunnats2004/proverif-compfun](https://hub.docker.com/repository/docker/arunnats2004/proverif-compfun/general)
- **Original Paper:** [Hash Gone Bad (USENIX Security'23)](https://www.usenix.org/conference/usenixsecurity23/presentation/cheval)
- **Original Repository:** [charlie-j/symbolic-hash-models](https://github.com/charlie-j/symbolic-hash-models)
- **ProVerif Documentation:** [bblanche.gitlabpages.inria.fr/proverif](https://bblanche.gitlabpages.inria.fr/proverif/)

## License

This project builds upon ProVerif 2.03 (INRIA, CNRS 2000-2021) and the modifications from "Hash Gone Bad" (2023).

## Contact

- Arun Natarajan - [GitHub](https://github.com/arunnats)
- Hafeez Muhammed - [GitHub](https://github.com/Hafeez-hm)
