local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key


return {
	s("pd", t("also loaded!!")),
  s("prd", {
        t('println!("'),
        i(1, "variable"),
        t(': {:?}", '),
        f(function(args)
            return args[1][1]
        end, {1}),
        t(");"),
    }),
  s("disp", {
        t({"impl std::fmt::Display for ", }),
        i(1, "StructName"),
        t({" {", "    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {", "        write!(f, \""}),
        i(2, "Format string"),
        t("\""),
        c(3, {
            t(""),
            t(", "),
        }),
        d(4, function(args)
            local nodes = {}
            local str = args[1][1]
            local count = select(2, string.gsub(str, "{}", ""))
            for j = 1, count do
                table.insert(nodes, t(", "))
                table.insert(nodes, i(j, "self.field" .. j))
            end
            return sn(nil, nodes)
        end, {2}),
        t({")", "    }", "}"}),
    }),
}
