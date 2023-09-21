-- local __lspOnAttach = function(client, bufnr)
--     require("lsp-format").on_attach(client)
-- end
-- local __lspCapabilities = function()
--     capabilities = vim.lsp.protocol.make_client_capabilities()
--
--     capabilities = require('cmp_nvim_lsp').default_capabilities()
--
--
--     return capabilities
-- end
--
-- local __setup = {
--     on_attach = __lspOnAttach,
--     capabilities = __lspCapabilities()
-- }
--
-- require('lspconfig').jdtls.setup(__setup)

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics,
--     {
--         virtual_text = false,
--         signs = true,
--         update_in_insert = false,
--         underline = true,
--     }
-- )

vim.cmd(
    [[set langmap='q,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,/[,=],aa,os,ed,uf,ig,dh,hj,tk,nl,s\\;,-',\\;z,qx,jc,kv,xb,bn,mm,w\\,,v.,z/,[-,]=,\"Q,<W,>E,PR,YT,FY,GU,CI,RO,LP,?{,+},AA,OS,ED,UF,IG,DH,HJ,TK,NL,S:,_\",:Z,QX,JC,KV,XB,BN,MM,W<,V>,Z?]]
)
