local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local extras = require "luasnip.extras"
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require "luasnip.extras.expand_conditions"
local postfix = require("luasnip.extras.postfix").postfix
local types = require "luasnip.util.types"
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

return {
  s("pde", {
    t 'println!("',
    i(1, ""),
    t ': {:?}", ',
    i(2, ""),
    t {");", "", "" },
  }),
  s("pdi", {
    t 'println!("',
    i(1, ""),
    t ': {}", ',
    i(2, ""),
    t {");", "", "" },
  }),

  -- Display impl
  s("disp", {
    t { "impl std::fmt::Display for " },
    i(1, ""),
    t { " {", "    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {", '        write!(f, self."' },
    i(2, ""),
    t '"',
    d(3, function(args)
      local nodes = {}
      local str = args[1][1]
      local count = select(2, string.gsub(str, "{}", ""))
      for j = 1, count do
        table.insert(nodes, t ", ")
        table.insert(nodes, i(j, "" .. j))
      end
      return sn(nil, nodes)
    end, { 2 }),
    t { ")", "    }", "}" },
  }),

  -- useful for heaps
  s("ord", {
        t({"impl Ord for "}),
        i(1, ""),
        t({" {", "    fn cmp(&self, other: &Self) -> std::cmp::Ordering {", "        self."}),
        i(2, ""),
        t(".cmp(&other."),
        f(function(args) return args[1][1] end, {2}),
        t(")"),
        c(3, {
            t(""),
            t(".reverse()"),
        }),
        t({"", "    }", "}", "", "impl PartialOrd for "}),
        f(function(args) return args[1][1] end, {1}),
        t({" {", "    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {", "        Some(self.cmp(other))", "    }", "}"}),
    })
  

}
