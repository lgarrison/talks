---
# You can also start simply with 'default'
theme: default
# background: https://cover.sli.dev
title: Recent and Planned Abacus N-body Simulations
# apply unocss classes to the current slide
class: text-center
# slide transition: https://sli.dev/guide/animations.html#slide-transitions
transition: slide-left
# enable MDC Syntax: https://sli.dev/features/mdc
mdc: true
lineNumbers: true
routerMode: hash
---

<style>
.katex {
  font-size: 1em; /* Adjust this value as needed */
}

.slidev-layout li {
  line-height: 1.4em; /* Adjust this value as needed */
}

.slidev-layout.cover h1 {
  font-size: 2.2em;
}
</style>

# Recent and Planned Abacus $N$-body Simulations

Lehman Garrison<br>
Software Engineer<br>
Scientific Computing Core<br>
Flatiron Institute<br><br>
Roman SC Cosmology WG Telecon<br>
November 4, 2025

<br>

<div class="image-container">
  <img src="./assets/scc.png" alt="SCC">
  <img src="./assets/abacus.png" alt="Abacus">
</div>

<style>
  .image-container {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 50px; /* space between images */
    margin: 0 auto;
  }
  
  .image-container img {
    height: 50px;
  }
</style>

<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->

---
layout: two-cols-header
---

# The Abacus Cosmological $N$-body Code

::left::

- A fast, accurate code for cosmological $N$-body simulations ([Garrison et al. 2021](https://academic.oup.com/mnras/article/508/1/575/6366254)) [![](https://img.shields.io/badge/DOI-10.1093/mnras/stab2482-blue)](https://doi.org/10.1093/mnras/stab2482)
- Primarily gravity-only, with optional neutrino treatment
- Force solver based on a high-order multipole method with exact decomposition between the near-field and far-field
  - Near-field uses exact, all-pairs ($N^2$) evaluation on the GPU
  - Far-field evaluated with CPU FFTs and SIMD-accelerated multipole kernels
  - Includes interactions between every particle in all periodic images
- High force accuracy (median relative error $10^{-5}$)
- Large number of global timesteps (often ~1000 in <span style="white-space: nowrap;">$\Lambda$CDM</span>)
<!-- - Multi-node parallelization using a 1D or 2D rectangular domain decomposition -->

::right::

<div style="text-align: center; font-size: smaller; width: 80%; margin: auto;">
<img src="./assets/force_split.png" style="max-width: 100%;">
A schematic illustration of the exact near-field/far-field separation of the Abacus force computation.
</div>

<br>

- On-the-fly analysis: halo finding (CompaSO), light cones
- Python analysis ecosystem (`abacusutils`)
<div class="github-container">
  <a href="https://github.com/abacusorg" class="github-link" aria-label="GitHub Profile">
    <img src="./assets/github-mark.svg" alt="GitHub" class="github-icon light-only">
    <img src="./assets/github-mark-white.svg" alt="GitHub" class="github-icon dark-only">
    github.com/abacusorg
  </a>
</div>

<!-- <div style="display: flex; justify-content: center;">

[![](https://img.shields.io/badge/DOI-10.1093/mnras/stab2482-blue)](https://doi.org/10.1093/mnras/stab2482)
</div> -->


<style>
.github-container {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}

.github-link {
  display: inline-flex;
  align-items: center;
  text-decoration: none;
  transition: opacity 0.2s;
  width: auto; /* Only as wide as content */
}

.github-link:hover {
  opacity: 0.7;
}

.github-icon {
  width: 24px;
  height: 24px;
  display: block;
  margin-right: 0.5ex;
}

.dark .dark-only {
  display: block;
}

.dark .light-only {
  display: none;
}

html:not(.dark) .dark-only {
  display: none;
}

html:not(.dark) .light-only {
  display: block;
}
</style>

---
routeAlias: sims
---

# Overview of Major Abacus Simulations

<style>
table {
  font-size: 1em;
}
table td, table th {
  padding: 0.2em 0.5em;
  line-height: 1.2;
}
</style>

| Name | Number of Particles | Date Completed | Notes | Slide |
| ---- | ------------------- | -------------- | ----- | ----- |
| AbacusSummit | 60 T | 2020 | Flagship suite for DESI | <Link to="AbacusSummit">🔗</Link> |
| AbacusPNG & DESI-2 | 1.1 T | 2023 | Post-AbacusSummit extension sims for primordial non-Gaussianity and high redshift | <Link to="png">🔗</Link> |
| <hr> | <hr> | <hr> | <hr> | <hr> |
| AbacusSummit $w_0w_a$ | 8 T? | Early 2026? | DESI request submitted for Perlmutter time | <Link to="w0wa">🔗</Link> |
| Backlight | 22 T? | Mid 2026? | Flatiron project focused on light cones and CMB lensing | <Link to="backlight">🔗</Link> |
| Frontier | ? | Late 2026? | Proposal submitted for new flagship | <Link to="frontier">🔗</Link> |

---

<img src="./assets/AbacusSummit_slide_dpi72.png" class="absolute inset-0 w-full h-full object-cover">

---
layout: two-cols-header
routeAlias: AbacusSummit
---

# AbacusSummit

::left::

- Flagship suite of $N$-body simulations to fulfill (and exceed) the DESI simulation requirements
- Run in 2020 on OLCF's Summit supercomputer
- Data products:
  - CompaSO halo catalogs from z=0.1 to z=8 at 12 primary and 21 secondary redshifts
  - Particle subsamples (3% + 7%) at primary redshifts
  - Merger trees based on PID tracking
  - Particle & halo light cones (octant to z=0.8, two smaller patches to z=2.4)
  - Matter power spectra
  - Some full snapshots
- Non-clustering neutrino approximation
- Discreteness-corrected 2LPT initial conditions
- Softening fixed in proper coordinates

::right::

- Data access
  - All 2 PB of data is public
  - Globus from NERSC (disk), Globus from OLCF Constellation (tape), Flatiron Institute BinderHub (explore data remotely in JupyterLab)
- Papers
  - Simulations: [Maksimova et al. (2021) ![](https://img.shields.io/badge/DOI-10.1093/mnras/stab2484-blue)](https://doi.org/10.1093/mnras/stab2484)
  - CompaSO halo finder: [Hadzhiyska et al. (2021) ![](https://img.shields.io/badge/DOI-10.1093/mnras/stab2980-blue)](https://doi.org/10.1093/mnras/stab2980)
  - Merger trees & cleaning: [Bose et al. (2022) ![](https://img.shields.io/badge/DOI-10.1093/mnras/stac555-blue)](https://doi.org/10.1093/mnras/stac555)
  - Halo light cones: [Hadzhiyska et al. (2021) ![](https://img.shields.io/badge/DOI-10.1093/mnras/stab3066-blue)](https://doi.org/10.1093/mnras/stab3066)
- Documentation: [abacussummit.readthedocs.io](https://abacussummit.readthedocs.io/)

<!-- <img src="./assets/AbacusSummit_logo_bw.png" width=50% style="margin: auto; margin-top: 50px;"> -->

---

# AbacusSummit Table of Simulations

<style>
table {
  font-size: 0.85em;
}
table td, table th {
  padding: 0.2em 0.5em;
  line-height: 1.2;
}
</style>

| Spec. | $N$ | Size (Mpc/$h$) | Particle mass<br>($M_\odot h^{-1}$) | Final $z$ | Num. boxes | Total node-hours<br>(per-sim) | Data products, compressed |
|---|---:|---:|---:|---:|---:|---:|---:|
| `base` | $6912^3$ | 2000 | $2.1 \times 10^9$  | 0.1 | 139 | 250 K (1800) | 1600 TB |
| `huge` | $8640^3$ | 7500 | $5.7 \times 10^{10}$ | 0.1 | 2 | 6.5 K (3300) | 100 TB |
| `high` | $6300^3$ | 1000 | $3.5 \times 10^8$ | 0.1 | 1 | 1.9 K (1900) | 40 TB |
| `hugebase` | $2304^3$ | 2000 | $5.7 \times 10^{10}$ | 0.1 | 25 | 1.1 K (43) | 22 TB |
| `highbase` | $3456^3$ | 1000 | $2.1 \times 10^9$ | 0.1 | 2/1 | 790 (260) | 12 TB |
| `fixedbase` | $4096^3$ | 1185 | $2.1 \times 10^9$ | 0.1 | 5/1 | 2.6 K (440) | 39 TB |
| `small` | $1728^3$ | 500 | $2.1 \times 10^9$ | 0.2 | 1643 | 32 K (20) | 140 TB |
| `ScaleFree` | $4096^3$, $6192^3$ | | | | 4 | | |
| `HighZ` | $6144^3$ | 20, 80, 300 | $3.0 \times 10^3$, $1.9 \times 10^5$, $1.0 \times 10^7$ | 12, 8, 3.5 | 3 | | |
| **Total** | **60 T** | **$2400\,(\mathrm{Gpc}/h)^3$** | | | | **290 K** | **2000 TB** |

---

[AbacusSummit Many Universes Video](https://d1qdmld16vdglj.cloudfront.net/abacussummit_universes_scatter_fps48_1080p.webm)

<SlidevVideo v-click autoplay controls class="absolute inset-0 w-full h-full object-cover">
  <source src="https://d1qdmld16vdglj.cloudfront.net/abacussummit_universes_scatter_fps48_1080p.webm" type="video/webm">
  <p>
    Your browser does not support videos.
  </p>
</SlidevVideo>

---
layout: two-cols-header
routeAlias: png
---

# AbacusPNG and DESI-2 Simulations
- In 2023, we set up Abacus on Perlmutter to run a small set of simulations
- These simulations use the AbacusSummit data model and thus we consider them AbacusSummit "extension" sims
- Available on NERSC

<br>

::left::

## AbacusPNG
- Simulations using initial conditions with local-type primordial non-Gaussianity ($f_\mathrm{NL}$) in the initial conditions
- `zeldovich-PLT` code modified to implement $f_\mathrm{NL}$
- Described in [Hadzhiyska et al. (2024) ![](https://img.shields.io/badge/DOI-10.1103/PhysRevD.109.103530-blue)](https://doi.org/10.1103/PhysRevD.109.103530)
- $f_\mathrm{NL}$ values of -100, -30, 0, 30, 100

::right::

## DESI-2
- Higher-resolution simulations with more high-redshift outputs than AbacusSummit
- Designed for DESI-2 forecasts
- First simulations to use the new Abacus 2D domain decomposition
- Minor improvements for high redshift accuracy
  - Proper softening length is smaller and reaches 1/40th of the particle spacing at z=2
  - Input linear power spectrum taken at z=2
- Not described in a publication, but available on NERSC

---

# Table of AbacusPNG and DESI-2 Simulations

| Spec. | $N$ | Size (Mpc/$h$) | Particle mass<br>($M_\odot h^{-1}$) | Final $z$ | Num. boxes |
|---|---:|---:|---:|---:|---:|
| `AbacusPNG` | $4096^3$ | 2000 | $1.5 \times 10^{10}$  | 0.3 | 10 |
| `DESI-2` | $6000^3$, $6192^3$ | 1250, 750 | $7.9 \times 10^8$, $1.1 \times 10^8$ | 2.0 | 2 |

---
layout: section
---

# Planned Simulations

---
routeAlias: w0wa
---

# DESI $w_0w_a$ Simulations
- DESI Cross-Analysis Infrastructure (CAI) WG has identified having simulations in the best-fit DR2 $w_0w_a$ cosmology as a priority
- CAI requested GPU and disk for 25 sims in the AbacusSummit `base` data model (8.3 T particles)
- These sims may or may not happen. More so than GPU time, disk space is a precious resource!
- Timeline: early 2026?

| Spec. | $N$ | Size (Mpc/$h$) | Particle mass<br>($M_\odot h^{-1}$) | Final $z$ | Num. boxes |
|---|---:|---:|---:|---:|---:|
| `base` | $6912^3$ | 2000 | $2.1 \times 10^9$  | 0.1 | 25 |

---
routeAlias: backlight
---

# AbacusBacklight
- A suite of simulations with robust light cone data products for analyzing CMB lensing
- Collaboration of Adrian Bayer (Flatiron Institute), Francisco Villaescusa-Navarro (FI), Lehman Garrison (FI), Will Coulton (Cambridge)
- Uses upgraded Abacus light-cone handling capabilities
- Running on Flatiron Institute cluster
- Initial conditions seeded with a different phase per simulation, suitable for simulation-based inference (SBI)
- Data products
  - Full-sky light cones to z=3.3 via box repetitions
  - Matter light cones (HEALPix maps) separated into halo and field components
  - Density and momentum light cones
  - Halo light cones generated via merger trees and interpolation
- Timeline: mid-2026? Simulations have already started.

| Spec. | $N$ | Size (Mpc/$h$) | Particle mass<br>($M_\odot h^{-1}$) | Final $z$ | Num. boxes |
|---|---:|---:|---:|---:|---:|
| `AbacusBacklight` | $2800^3$ | 1000 | $3.6 \times 10^9$  | 0.0 | 1024 |

---
layout: two-cols-header
routeAlias: frontier
---

# AbacusFrontier

::left::

- An ambitious simulation effort to succeed AbacusSummit
- Submitted as a DOE INCITE 2026 proposal to run on the Frontier supercomputer (PI: Daniel Eisenstein, Harvard/CfA)
- Abacus successfully ported to HIP/AMD GPUs
- Specifics will depend on whether the proposal is accepted, and if so, how much time is allocated
- Key aspect is the addition of a new physics model
  - "Massless aggregator particles" (MAPs) are employed to model the cooling of baryons in dark matter halos
  - MAPs provide sites for galaxy placement in an HOD-style framework
  - Johnson et al. (in prep.)
- Timeline: simulations finish late 2026, with data release in early 2027?

::right::

<div style="text-align: center; font-size: smaller; width: 150px; margin: auto;">
<img src="./assets/johnson2022_alexander_3.jpg" style="max-width: 80%; display: block; margin: 0 auto;">
Alexander Johnson (Harvard)
</div>

---
# Summary
- <Link to="sims" title="Overview of Major Abacus Simulations"/>
