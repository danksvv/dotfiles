local M = {}

function M.extract_ids_classes()
  -- 1. Limpiar el registro 'a' para empezar desde cero
  vim.fn.setreg("a", {})

  -- 2. Copiar (Yank) todas las líneas que tengan id="..." o class="..." al registro 'a'
  -- Usamos 'silent!' para que no de error si no encuentra nada
  vim.cmd('silent! g/\\v(id|class)=\\"([^\\"]*)\\"/y A')

  -- 3. Verificación de seguridad: ¿Encontramos algo?
  local content = vim.fn.getreg("a")
  if content == "" or content == nil then
    print("⚠️ No se encontraron atributos id o class en este archivo.")
    return
  end

  -- 4. Crear nuevo buffer vertical (vnew) u horizontal (new)
  vim.cmd("vnew")
  vim.cmd("file IDs_y_Clases_Extraidas.txt")

  -- 5. PEGAR SÍNCRONO (La corrección clave)
  -- 'put a' pega el contenido del registro 'a' inmediatamente.
  -- '0' indica que lo pegue al principio del archivo.
  vim.cmd("0put a")

  -- 6. Limpieza: Eliminar la línea vacía extra que suele quedar al final
  vim.cmd("$d")

  -- 7. Sustitución para dejar solo el valor limpio
  -- Usamos 'silent!' para suprimir errores si alguna línea no coincide perfectamente
  -- La regex busca toda la línea (.*) y la reemplaza solo por el valor del grupo captura (\2)
  vim.cmd('silent! %s/.*\\v(id|class)=\\"([^\\"]*)\\".*/\\2/g')

  -- 8. Mensaje de éxito
  print("✅ Extracción completada.")
end

return {
  {
    "mason-org/mason.nvim", -- Placeholder
    keys = {
      {
        "<leader>xic",
        M.extract_ids_classes,
        mode = "n",
        desc = "[X]traer [I]Ds y [C]lasses",
      },
    },
  },
}
