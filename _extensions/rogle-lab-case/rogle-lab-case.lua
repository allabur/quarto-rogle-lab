-- Igual que rogle-lab.lua: expone el resources/ propio de esta extensión
-- como $rogle-lab-resources-dir$ para que los partials puedan referenciar
-- los logos/iconos empaquetados sin depender de dónde se instaló la
-- extensión (_extensions/rogle-lab-case/ en este repo,
-- _extensions/<owner>/rogle-lab-case/ una vez instalada vía `quarto add`).
function Meta(meta)
  meta["rogle-lab-resources-dir"] = pandoc.MetaString(quarto.utils.resolve_path("resources") .. "/")
  return meta
end
