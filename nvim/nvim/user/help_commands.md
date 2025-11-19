# 🚀 Guía Rápida de Comandos en LazyVim

---

## 🗺️ Gestión de Ventanas (Splits)

| Atajo                 | Descripción       | Acción                                               |
| :-------------------- | :---------------- | :--------------------------------------------------- |
| `<space>` + `w` + `v` | Split Vertical    | Crea una nueva ventana vertical.                     |
| `<space>` + `w` + `s` | Split Horizontal  | Crea una nueva ventana horizontal.                   |
| `<space>` + `w` + `w` | **Switch Window** | Cambia el foco entre las ventanas (splits) abiertas. |
| `<space>` + `w` + `d` | Cerrar Ventana    | Cierra la ventana activa.                            |

---

## 🔍 Búsqueda y Navegación de Archivos

| Atajo                 | Descripción       | Acción/Alcance                                                                |
| :-------------------- | :---------------- | :---------------------------------------------------------------------------- |
| `<space>` + `<space>` | **Find Files**    | Busca archivos desde el directorio raíz donde se inició Vim.                  |
| `<space>` + `s` + `g` | Find Grep         | Búsqueda **dentro del contenido** de los archivos abiertos o en el proyecto.  |
| `<space>` + `f` + `c` | Find Config Files | Busca archivos de configuración específicos de LazyVim (lazy, plugins, etc.). |

---

## 💻 Comandos Git (Usando LazyGit/Fugitive)

| Atajo                 | Descripción    |
| :-------------------- | :------------- | --------------------------------------------- |
| `<space>` + `g` + `s` | **Git Status** | Muestra el estado de los cambios realizados.  |
| `<space>` + `g` + `l` | Git Log        | Muestra el historial de logs del repositorio. |

---

## ✨ Multi-Cursor / Reemplazo de Ocurrencias

Este es un proceso de múltiples pasos para reemplazar rápidamente una palabra en varias ocurrencias.

1.  **Selección:** En modo **NORMAL**, sitúate sobre la palabra y pulsa `Shift` + `*` para seleccionar todas las ocurrencias en el documento.
2.  **Edición:** Usa `c` + `g` + `n`. Esto te lleva al modo **INSERTAR**, borra la palabra actual, y puedes escribir la sustituta.
3.  **Aplicación Recursiva:** Sal del modo **INSERTAR**. En modo **NORMAL**, pulsa `n` + `.` para saltar a la siguiente ocurrencia y aplicar el mismo reemplazo recursivamente.

---

## ⚓ Harpoon (Marcadores Rápidos)

| Atajo                | Descripción         |
| :------------------- | :------------------ | ---------------------------------------------------- | ----------------- | ------------------------------------------------------------- |
| `<space>` + `H`      | **Guardar Archivo** | Guarda el archivo actual en la lista de Harpoon.     |
| `<space>` + `h`      | Mostrar Lista       | Muestra la lista de archivos guardados (marcadores). |
| `<space>` + `1` \*\* | ** `2` **           | ** `3` **...\*\*                                     | Navegación Rápida | Va directamente al archivo guardado según su número de orden. |

---

## 📝 Mini-Surround (Envoltura Rápida)

| Atajo                                     | Uso                                                           | Ejemplo               |
| :---------------------------------------- | :------------------------------------------------------------ | :-------------------- |
| `<selección>` + `g` + `s` + `a` + **`'`** | Selecciona una ocurrencia y la envuelve con comillas simples. | `word` $\to$ `'word'` |
| `<selección>` + `g` + `s` + `a` + **`"`** | Selecciona una ocurrencia y la envuelve con comillas dobles.  | `word` $\to$ `"word"` |
| `<selección>` + `g` + `s` + `a` + **`{`** | Selecciona una ocurrencia y la envuelve con llaves.           | `word` $\to$ `{word}` |
