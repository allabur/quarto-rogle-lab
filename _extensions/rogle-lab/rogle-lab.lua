-- Exposes this extension's own resources/ directory as a document metadata
-- variable ($rogle-lab-resources-dir$), so template-partials can reference
-- bundled images (logos, CC license icons) with a path that resolves
-- correctly no matter where quarto installed the extension:
-- _extensions/rogle-lab/ in this repo, _extensions/<owner>/rogle-lab/ once
-- installed elsewhere via `quarto add`/`quarto use template`.
-- quarto.utils.resolve_path resolves relative to this filter's own file
-- location, which is always a sibling of resources/.
function Meta(meta)
  meta["rogle-lab-resources-dir"] = pandoc.MetaString(quarto.utils.resolve_path("resources") .. "/")
  return meta
end
