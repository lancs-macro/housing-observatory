<!-- knowledge:start -->
## Knowledge wiki
This repo's wiki lives in `./wiki` (committed with the code; overview: `wiki/housing-site-main.md`). It is linked into the
shared vault at `./kb` (-> C:\Users\User\knowledge), where `kb/CLAUDE.md` holds the rules (frontmatter, wikilinks, INGEST/QUERY/LINT).
- Session start: read `kb/inbox/housing-site-main.md`, act on items, move them under `## Done`.
- Write the wiki to the repo wiki standard: `kb/REPO-WIKI.md` (layout, page types, frontmatter, links). Scaffold pages with `python kb/scripts/new_page.py housing-site-main architecture|decision|runbook|integration|concept "<Title>"`.
- Update the wiki page that describes a behaviour in the same change that alters it; then run `python kb/scripts/reindex.py` and `python kb/scripts/lint.py`.
- Find things with `python kb/scripts/search.py "<terms>"` before browsing `kb/wiki/INDEX.md`. Never edit `kb/raw/`.
<!-- knowledge:end -->
