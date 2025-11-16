return {
  {
    "nvim-mini/mini.animate",
    -- Esto asegura que el plugin se inicialice DESPUÉS de cargarse.
    config = function()
      require("mini.animate").setup({
        -- Configuración de la animación del cursor.
        cursor = { duration = 250, style = "in_out_quad" },

        -- Puedes añadir estas líneas para ver más efectos:
        -- scroll = { duration = 250, style = 'in_out_quad' },
        -- win_switch = { duration = 250, style = 'in_out_quad' },
      })
    end,
  },
}
