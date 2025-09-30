return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "jbyuki/one-small-step-for-vimkind",

      -- stylua: ignore
      config = function()
        local dap = require("dap")
        dap.adapters.nlua = function(callback, conf)
          local adapter = {
            type = "server",
            host = conf.host or "127.0.0.1",
            port = conf.port or 8086,
          }
          if conf.start_neovim then
            local dap_run = dap.run
            dap.run = function(c)
              adapter.port = c.port
              adapter.host = c.host
            end
            require("osv").run_this()
            dap.run = dap_run
          end
          callback(adapter)
        end
        dap.configurations.lua = {
          {
            type = "nlua",
            request = "attach",
            name = "Run this file",
            start_neovim = {},
          },
          {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance (port = 8086)",
            port = 8086,
          },
        }
      end,
            },
        },
    },
    {
        "jbyuki/one-small-step-for-vimkind",
  -- stylua: ignore
  config = function()
    local dap = require("dap")
    dap.adapters.nlua = function(callback, conf)
      local adapter = {
        type = "server",
        host = conf.host or "127.0.0.1",
        port = conf.port or 8086,
      }
      if conf.start_neovim then
        local dap_run = dap.run
        dap.run = function(c)
          adapter.port = c.port
          adapter.host = c.host
        end
        require("osv").run_this()
        dap.run = dap_run
      end
      callback(adapter)
    end
    dap.configurations.lua = {
      {
        type = "nlua",
        request = "attach",
        name = "Run this file",
        start_neovim = {},
      },
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance (port = 8086)",
        port = 8086,
      },
    }
  end,
        opts = function()
            local dap = require("dap")
            if not dap.adapters["codelldb"] then
                require("dap").adapters["codelldb"] = {
                    type = "server",
                    host = "localhost",
                    port = "${port}",
                    executable = {
                        command = "codelldb",
                        args = {
                            "--port",
                            "${port}",
                        },
                    },
                }
            end
            for _, lang in ipairs({ "c", "cpp" }) do
                dap.configurations[lang] = {
                    {
                        type = "codelldb",
                        request = "launch",
                        name = "Launch file",
                        program = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        end,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "codelldb",
                        request = "attach",
                        name = "Attach to process",
                        pid = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                    },
                }
            end
        end,
    },
}
