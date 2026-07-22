# RealFPS Architecture

> Internal structure of RealFPS Windows Gaming Optimizer.

---

## Architecture Overview

```mermaid
flowchart TD

A[RealFPS Core]

A --> B[Interface Layer]

A --> C[Detection Engine]

A --> D[Optimization Engine]

A --> E[Recovery System]

A --> F[Reporting System]


B --> B1[Menu System]

B --> B2[Color Engine]

B --> B3[Animation]


C --> C1[CPU Detection]

C --> C2[GPU Detection]

C --> C3[RAM Detection]

C --> C4[Windows Detection]


D --> D1[Power Management]

D --> D2[Registry Tweaks]

D --> D3[Services]

D --> D4[Network]


E --> E1[Restore Point]

E --> E2[Backup]

E --> E3[Restore]


F --> F1[System Report]

F --> F2[Benchmark]
```

---

## Core Design

RealFPS follows:

```
User
 |
Interface
 |
Router
 |
Module
 |
System API
 |
Windows
```

---

## Main Components

| Component | Purpose |
|-|-|
| Core Engine | Controls execution |
| UI Engine | Handles CMD interface |
| Detection Engine | Reads hardware |
| Optimization Engine | Applies tweaks |
| Recovery System | Protects user |
| Report System | Shows results |
