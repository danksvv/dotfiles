return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local autotag = require("nvim-ts-autotag")
    autotag.setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    })

    -- ⚡ Patch: extender configuración HTML para incluir encabezados
    local TagConfigs = require("nvim-ts-autotag.config.init")
    local html_conf = TagConfigs:get("html")

    if html_conf then
      TagConfigs:update(html_conf:override("html", {
        -- esto fuerza a reconocer cualquier nombre de etiqueta al estilo HTML, incluidos h1–h6
        start_tag_pattern = { "element", "STag", "start_tag" },
        end_tag_pattern = { "element", "ETag", "end_tag" },
        valid_tag_names = setmetatable({
          h1 = true,
          h2 = true,
          h3 = true,
          h4 = true,
          h5 = true,
          h6 = true,
        }, { __index = html_conf.valid_tag_names }),
      }))
    end
  end,
}
