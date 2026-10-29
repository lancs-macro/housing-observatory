---
title: housing-site-main
type: project
status: active
created: 2026-10-27
updated: 2026-10-29
sources: []
scope: housing-observatory
tags: [project, frontend]
verified_commit: f64b5f8be288cd1df310d2771b2c1a466c331c2c
files: [index.html, Makefile, nav.html, footer.html, assets/js/stat.js]
---
# housing-site-main

Static HTML front page of the Housing Observatory (page title "UK Housing Observatory") with about, dashboard, resources and disclaimer pages.

Part of [[concepts/housing-observatory]]. GitHub: `lancs-macro/housing-observatory`.

## Stack
Plain HTML, CSS and JS; no build step. `nav.html` and `footer.html` are shared partials. `assets/js/stat.js` holds the headline statistics.

## Run and test
Open `index.html` or serve the folder with any static server. `make download_json` and `make download_png` fetch `output/stat.js` and `output/comparison.png` from the `lancs-macro/ukho-dashboard` repo into `assets/`.

## Layout
- `index.html`, `about.html`, `dashboard.html`, `resources.html`, `disclaimer.html`, `404.html`, `sitemap.xml`
- `assets/` css, img, js

## Unknowns
- Where it is deployed: no `netlify.toml` or deploy script here (unverified).
- How it relates to [[projects/housing-site-uk/housing-site-uk]]: both use the title "UK Housing Observatory" and almost the same files. Pick one as canonical or document the split.
- `dashboard.html` links the old `lancs-macro.shinyapps.io` dashboard; the UK site has since moved to Posit Connect Cloud.

Related: [[concepts/housing-observatory]], [[conventions]], [[inbox/housing-site-main]].
