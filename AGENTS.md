# Build/Lint/Test Commands
- **Lint:** Use `lua-language-server`. Configuration is provided in `.luarc.json`.
- **Test:** No automated tests. Manually verify changes by loading the plugin in Neovim and inspecting the highlights.
- **Build:** No build step required; Lua code is interpreted directly by Neovim.

# Code Style Guidelines
- **Language:** Lua 5.1/JIT (Neovim compatible).
- **Indentation:** Use 4 spaces for indentation.
- **Formatting:** Follow the style of existing files (e.g., `lua/neodef/groups.lua`). Align table keys where appropriate.
- **Naming:**
  - Use `snake_case` for functions and variables.
  - Use `PascalCase` for highlight group names.
  - Use `M` for the module table in standard module definitions.
- **Imports:** Localize requires, e.g., `local U = require("neodef.utils")`.
- **Error Handling:** Use `vim.notify("Message", vim.log.levels.ERROR)` for user-facing errors.
- **Structure:** Standard Lua module pattern: `local M = {} ... return M`.
- **Documentation:** Keep it minimal; the codebase is small and self-explanatory.
