# SPIT (Spring Boot Inspection Toolkit)

**SPIT** is an open-source collection of Bash scripts designed to inspect and analyze Spring Boot codebases. It assists developers in identifying code smells, unused configurations, dependency issues, and runtime risks within modern Java microservices build with Spring Boot. Each script in the toolkit focuses on a specific inspection area, allowing for modular usage and seamless integration into automation workflows.
---

## 🔧 Scripts Overview

| Script                          | Description |
|----------------------------------|-------------|
| `spit_caching_usage.sh`          | Detects usage of caching annotations and reports cache-related configuration. |
| `spit_circuit_breakers.sh`       | Scans for circuit breaker usage like Resilience4j or Hystrix and extracts fallback mechanisms. |
| `spit_dead_weight.sh`            | Finds unused classes, packages, and configuration files (aka "dead weight"). |
| `spit_dependency_updates.sh`     | Checks for outdated dependencies via build files like `pom.xml` or `build.gradle`. |
| `spit_external_calls.sh`         | Maps external HTTP and messaging system calls, including APIs and queues. |
| `spit_format_check.sh`           | Checks code formatting using tools like `spotless`, `google-java-format`, or custom linters. |
| `spit_test_analysis.sh`          | Analyzes test coverage, test structure, and identifies flaky or long-running tests. |
| `spit_unused_dependencies.sh`    | Identifies unused Maven or Gradle dependencies, reducing build bloat. |

---

## 🚀 Getting Started

### Prerequisites

- Unix-based system (macOS/Linux)
- Bash 5+
- `find`, `grep`, `awk`, `sed`, and other core utils
- Java tooling installed (`mvn`, `gradle`, etc., depending on script usage)

### Usage

Run individual scripts directly:

```bash
chmod +x spit_caching_usage.sh
./spit_caching_usage.sh /path/to/springboot/project
```

## 🧠 Use Cases
Pre-deployment code health checks

Onboarding audits for legacy Spring Boot services

CI integration for code quality reporting

Cost analysis based on unused or inefficient code

## 🛠️ Contributing
Contributions are welcome! Please open an issue or submit a pull request with improvements, bug fixes, or new inspection scripts.

## 📄 License
MIT License — free to use and modify.