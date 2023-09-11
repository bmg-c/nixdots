{
  # # Remove active
  "[" = "no_op";
  # "]" = "no_op";
  # "'" = "no_op";
  # "," = "no_op";
  # "." = "no_op";
  # p = "no_op";
  # y = "no_op";
  # f = "no_op";
  # g = "no_op";
  # c = "no_op";
  # r = "no_op";
  # l = "no_op";
  # "/" = "no_op";
  # "=" = "no_op";
  "\\" = "no_op";
  # a = "no_op";
  # o = "no_op";
  # e = "no_op";
  # u = "no_op";
  # i = "no_op";
  # d = "no_op";
  # h = "no_op";
  # t = "no_op";
  # n = "no_op";
  # s = "no_op";
  minus = "no_op";
  # ";" = "no_op";
  # q = "no_op";
  # j = "no_op";
  # k = "no_op";
  # x = "no_op";
  # b = "no_op";
  # m = "no_op";
  # w = "no_op";
  # v = "no_op";
  # z = "no_op";
  # "{" = "no_op";
  "}" = "no_op";
  # "\"" = "no_op";
  # "<" = "no_op";
  # ">" = "no_op";
  # P = "no_op";
  # Y = "no_op";
  F = "no_op";
  # C = "no_op";
  # R = "no_op";
  # L = "no_op";
  "?" = "no_op";
  "+" = "no_op";
  # "|" = "no_op";
  # A = "no_op";
  # O = "no_op";
  E = "no_op";
  # U = "no_op";
  # I = "no_op";
  D = "no_op";
  # H = "no_op";
  # T = "no_op";
  N = "no_op";
  # S = "no_op";
  # "_" = "no_op";
  ":" = "no_op";
  # Q = "no_op";
  # J = "no_op";
  K = "no_op";
  # X = "no_op";
  # B = "no_op";
  M = "no_op";
  # W = "no_op";
  # V = "no_op";
  # Z = "no_op";

  # # Movement
  d = "move_char_left";
  h = "move_visual_line_down";
  t = "move_visual_line_up";
  n = "move_char_right";
  left = "move_char_left";
  down = "move_visual_line_down";
  up = "move_visual_line_up";
  right = "move_char_right";
  "," = "move_next_word_start";
  x = "move_prev_word_start";
  # "." = "move_next_long_word_end";
  "<" = "move_next_long_word_start";
  X = "move_prev_long_word_start";
  ">" = "move_next_long_word_end";
  y = "find_till_char";
  u = "find_next_char";
  Y = "till_prev_char";
  U = "find_prev_char";
  I = "goto_line";
  A-v = "no_op";
  "A-." = "repeat_last_motion";
  home = "goto_line_start";
  end = "goto_line_end";
  # C-x = "no_op";
  C-b = "page_up";
  # C-u = "no_op";
  C-f = "page_down";
  pageup = "page_up";
  pagedown = "page_down";
  C-g = "no_op";
  C-u = "half_page_up";
  C-e = "no_op";
  C-d = "half_page_down";
  # C-c = "no_op";
  C-i = "jump_forward";
  C-r = "no_op";
  C-o = "jump_backward";
  # C-o = "no_op";
  C-s = "save_selection";

  # Changes
  p = "replace";
  P = "replace_with_yanked";
  "~" = "switch_case";
  "`" = "switch_to_lowercase";
  # "A-`" = "no_op";
  "A-`" = "switch_to_uppercase";
  c = "insert_mode";
  a = "append_mode";
  C = "insert_at_line_start";
  A = "insert_at_line_end";
  r = "open_below";
  R = "open_above";
  v = "no_op"; # "N/A"
  g = "undo";
  G = "redo";
  A-g = "no_op";
  A-u = "earlier";
  A-G = "no_op";
  A-U = "later";
  f = "yank";
  l = "paste_after";
  L = "paste_before";
  "_" = "no_op"; # "select_register"
  V = "indent";
  W = "unindent";
  "]" = "no_op"; # "format_selections"
  e = "delete_selection";
  A-e = "no_op";
  A-d = "delete_selection_noyank";
  j = "change_selection";
  A-j = "no_op";
  A-c = "change_selection_noyank";
  # C-a = "no_op";
  C-a = "increment";
  C-q = "no_op";
  C-x = "decrement";
  "\"" = "no_op"; # "record_macro"
  "'" = "no_op"; # "replay_macro"

  # Shell
  "|" = "shell_pipe";
  # "A-|" = "no_op";
  "A-|" = "shell_pipe_to";
  "!" = "shell_insert_output";
  # "A-!" = "no_op";
  "A-!" = "shell_append_output";
  "$" = "shell_keep_pipe";

  # Selection manipulation
  o = "select_regex";
  O = "split_selection";
  # A-o = "no_op";
  A-s = "split_selection_on_newline";
  "A-{" = "no_op";
  "A-_" = "merge_consecutive_selections";
  "&" = "align_selections";
  "{" = "trim_selections";
  s = "collapse_selection";
  # A-s = "no_op";
  "A-;" = "flip_selections";
  A-S = "no_op";
  "A-:" = "ensure_selections_forward";
  w = "keep_primary_selection";
  A-w = "no_op";
  "A-," = "remove_primary_selection";
  J = "copy_selection_on_next_line";
  # A-J = "no_op";
  A-C = "copy_selection_on_prev_line";
  "(" = "rotate_selections_backward";
  ")" = "rotate_selections_forward";
  # "A-(" = "no_op";
  "A-(" = "rotate_selection_contents_backward";
  # "A-)" = "no_op";
  "A-)" = "rotate_selection_contents_forward";
  "%" = "select_all";
  q = "extend_line_below";
  Q = "extend_to_line_bounds";
  A-q = "no_op";
  A-x = "shrink_to_line_bounds";
  H = "join_selections";
  A-H = "no_op";
  A-J = "join_selections_space";
  T = "keep_selections";
  # A-T = "no_op";
  A-K = "remove_selections";
  C-j = "no_op";
  C-c = "toggle_comments";
  A-r = "no_op";
  A-o = "expand_selection";
  # A-up = "no_op";
  A-up = "expand_selection";
  # A-c = "no_op";
  A-i = "shrink_selection";
  # A-down = "no_op";
  A-down = "shrink_selection";
  A-l = "no_op";
  A-p = "select_prev_sibling";
  # A-left = "no_op";
  A-left = "select_prev_sibling";
  A-b = "no_op";
  A-n = "select_next_sibling";
  # A-right = "no_op";
  A-right = "select_next_sibling";

  # Search
  z = "search";
  Z = "rsearch";
  b = "search_next";
  B = "search_prev";
  "*" = "search_selection";

  # # Minor modes
  k = "select_mode";
  S = "command_mode";

  # View mode
  ";" = import ./normal/view.nix;

  # Goto mode
  i = import ./normal/goto.nix;

  # Match mode
  m = import ./normal/match.nix;

  # Window mode
  "C-," = "no_op";
  C-w = import ./normal/window.nix;
  space = import ./normal/space.nix;
  "=".e = "goto_next_diag";
  "/".e = "goto_prev_diag";
  "=".E = "goto_last_diag";
  "/".E = "goto_first_diag";
  "=".u = "goto_next_function";
  "/".u = "goto_prev_function";
  "=".y = "goto_next_class";
  "/".y = "goto_prev_class";
  "=".a = "goto_next_parameter";
  "/".a = "goto_prev_parameter";
  "=".j = "goto_next_comment";
  "/".j = "goto_prev_comment";
  "=".Y = "goto_next_test";
  "/".Y = "goto_prev_test";
  "=".l = "goto_next_paragraph";
  "/".l = "goto_prev_paragraph";
  "=".i = "goto_next_change";
  "/".i = "goto_prev_change";
  "=".I = "goto_last_change";
  "/".I = "goto_first_change";
  "=".space = "add_newline_below";
  "/".space = "add_newline_above";
}
