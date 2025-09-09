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
  s("!dd", {
    t 'println!("',
    i(1, ""),
    t ': {:?}", ',
    i(2, ""),
    t { ");" },
  }),

  s("!d", {
    t 'println!("',
    i(1, ""),
    t ': {:?}", ',
    f(function(args, snip)
      return args[1][1]
    end, { 1 }),
    t { ");" },
  }),
  s("trig", {
    i(1, "text_of_first"),
    i(2, { "first_line_of_second", "second_line_of_second" }),
    f(function(args, snip)
      --here
      -- order is 2,1, not 1,2!!
    end, { 1, 2 }),
  }),

  s("!p", {
    t 'println!("',
    i(1, ""),
    t ': {}", ',
    i(2, ""),
    t { ");", "", "" },
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
    t { "impl Ord for " },
    i(1, ""),
    t { " {", "    fn cmp(&self, other: &Self) -> std::cmp::Ordering {", "        self." },
    i(2, ""),
    t ".cmp(&other.",
    f(function(args)
      return args[1][1]
    end, { 2 }),
    t ")",
    c(3, {
      t "",
      t ".reverse()",
    }),
    t { "", "    }", "}", "", "impl PartialOrd for " },
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t {
      " {",
      "    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {",
      "        Some(self.cmp(other))",
      "    }",
      "}",
    },
  }),

  -- random macros
  s("mvec2d", {
    t "macro_rules! to_vec { ($($x:expr),*) => (vec![$($x.to_vec()),*]); }",
  }),
  s(
    "mpretty2d",
    t {
      "macro_rules! pretty_print_2d {",
      "    ($vec:expr) => {",
      "        for row in $vec.iter() {",
      "            for elem in row.iter() {",
      '                print!("{:4} ", elem);',
      "            }",
      "            println!();",
      "        }",
      "    };",
      "}",
    }
  ),

  -- clap boiler
  s(
    "!clap",
    t {
      "use std::path::PathBuf;",
      "",
      "use clap::{Parser, Subcommand};",
      "",
      "#[derive(Parser)]",
      "#[command(version, about, long_about = None)]",
      "struct Cli {",
      "    name: Option<String>,",
      "",
      '    #[arg(short, long, value_name = "FILE")]',
      "    config: Option<PathBuf>,",
      "",
      "    #[arg(short, long, action = clap::ArgAction::Count)]",
      "    debug: u8,",
      "",
      "#[command(subcommand)]",
      "    command: Option<Commands>,",
      "}",
      "",
      "#[derive(Subcommand)]",
      "enum Commands {",
      "    Test {",
      "        #[arg(short, long)]",
      "        list: bool,",
      "    },",
      "}",
      "",
      "fn main() {",
      "    let cli = Cli::parse();",
      "}",
    }
  ),

  s("!ife", {
    t "if ",
    i(1, "cond"),
    t " {",
    t { "", "    " },
    i(2, ""),
    t { "", "}" },
    t " else {",
    t { "", "    " },
    i(3, ""),
    t { "", "}" },
  }),

  s("!iflet", {
    t "if let Some(",
    i(1, "var"),
    t ") = ",
    i(2, "opt"),
    t " {",
    t { "", "    " },
    i(3, ""),
    t { "", "}" },
  }),

  -- just function
  s("!fn", {
    t "fn ",
    i(1, "name"),
    t "(",
    i(2, "args"),
    t ") -> ",
    i(3, "ret"),
    t " {",
    t { "", "    " },
    i(4, ""),
    t { "", "}" },
  }),

  -- function with Result and anyhow error
  s("!fnany", {
    t "fn ",
    i(1, "name"),
    t "(",
    i(2, "args"),
    t ") -> Result<",
    i(3, "()"),
    t ", anyhow::Error> {",
    t { "", "    " },
    i(4, "Ok(())"),
    t { "", "}" },
  }),

  s("!mat", {
    t "match ",
    i(1, "value"),
    t " {",
    t { "", "    " },
    i(2, "pattern"),
    t " => ",
    i(3, "expression"),
    t ",",
    t { "", "}" },
  }),

  s("!b", {
    t "{",
    t { "", "    " },
    i(1, ""),
    t { "", "}" },
  }),

  -- s("!time", {
  --   t { "let start_time = std::time::Instant::now();", "" },
  --   i(1, "/* to time */"),
  --   t { "", "let end_time = std::time::Instant::now();",
  --       "let duration = end_time.duration_since(start_time);",
  --       "println!(\"Time elapsed: {duration:?}\");" },
  -- }),

  s("timesnip", {
    t {
      "macro_rules! time {",
      "    ($expression:expr) => {",
      "        let start_time = std::time::Instant::now();",
      "        let result = $expression;",
      "        let end_time = std::time::Instant::now();",
      "        let duration = end_time.duration_since(start_time);",
      "        println!(\"Time elapsed for '{}': {:?}\", stringify!($expression), duration);",
      "        result",
      "    };",
      "}",
    },
  }),

  -- Usage snippet for the timed! macro
  s("!time", {
    t "time!(",
    i(1, "..."),
    t ")",
  }),

  --Result type
  s("!res", {
    t "Result<",
    i(1, "T"),
    t ", ",
    i(2, "E"),
    t ">",
  }),
}
