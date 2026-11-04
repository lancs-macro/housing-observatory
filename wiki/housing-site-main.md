---
title: housing-site-main
type: project
status: active
created: 2026-10-27
updated: 2026-11-04
sources: []
scope: housing-observatory
tags: [project, frontend]
verified_commit: f64b5f8be288cd1df310d2771b2c1a466c331c2c
files: [index.html, wrangler.jsonc, assets/css/style.css]
---
# housing-site-main

Gateway page of the Housing Observatory (housing-observatory.com): one static page that links to the UK and International observatories.

Part of [[concepts/housing-observatory]]. GitHub: `lancs-macro/housing-observatory`.

## Stack
Plain HTML and CSS; no build step. Hosted on Cloudflare Workers static assets (`wrangler.jsonc`, Worker `housing-observatory-main`, custom domains `housing-observatory.com` and `www`); a Redirect Rule sends `www` to the apex. Workers Builds deploys on push to `main`. Replaced Netlify on 2026-11-04.

## Run and test
Open `index.html` or serve the folder with any static server.

## Layout
`index.html`, `sitemap.xml`, `assets/css/style.css`, `assets/img/`.

## History
Until 2026-11-04 the repo held a full copy of the UK site (about, dashboard, resources pages), which never matched what the domain served. It was replaced by the live gateway page; the old files are in git history. See [[projects/housing-site-uk/housing-site-uk]].

## Unknowns
- None open.

Related: [[concepts/housing-observatory]], [[conventions]], [[inbox/housing-site-main]].

## Analytics
GA4 tag `G-ZHNETED6TG` (property "Housing Observatory - GA4"). The ID lives once, in `scripts/set_ga.py` (`GA_ID`); run `python scripts/set_ga.py` to rewrite every page, `--check` to verify. Replaced the dead `UA-129604855-5` tag on 2026-11-04.
