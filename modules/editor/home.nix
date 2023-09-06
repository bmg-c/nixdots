{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        scrolloff = 9;
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        line-number = "relative";
        indent-guides.render = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
      keys.normal = {
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
        "." = "move_next_word_end";
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
        ";" = {
          # Remove old
          "[" = "no_op";
          "]" = "no_op";
          "'" = "no_op";
          "," = "no_op";
          "." = "no_op";
          p = "no_op";
          # y = "no_op";
          f = "no_op";
          g = "no_op";
          c = "no_op";
          r = "no_op";
          l = "no_op";
          "/" = "no_op";
          "=" = "no_op";
          "\\" = "no_op";
          a = "no_op";
          o = "no_op";
          e = "no_op";
          u = "no_op";
          i = "no_op";
          d = "no_op";
          # h = "no_op";
          # t = "no_op";
          n = "no_op";
          s = "no_op";
          minus = "no_op";
          # ";" = "no_op";
          q = "no_op";
          # j = "no_op";
          k = "no_op";
          # x = "no_op";
          b = "no_op";
          # m = "no_op";
          w = "no_op";
          v = "no_op";
          z = "no_op";
          "{" = "no_op";
          "}" = "no_op";
          "\"" = "no_op";
          "<" = "no_op";
          ">" = "no_op";
          P = "no_op";
          Y = "no_op";
          F = "no_op";
          C = "no_op";
          R = "no_op";
          L = "no_op";
          "?" = "no_op";
          "+" = "no_op";
          "|" = "no_op";
          A = "no_op";
          O = "no_op";
          E = "no_op";
          U = "no_op";
          I = "no_op";
          D = "no_op";
          H = "no_op";
          T = "no_op";
          N = "no_op";
          S = "no_op";
          "_" = "no_op";
          ":" = "no_op";
          Q = "no_op";
          J = "no_op";
          K = "no_op";
          X = "no_op";
          B = "no_op";
          M = "no_op";
          W = "no_op";
          V = "no_op";
          Z = "no_op";

          ";" = "align_view_center";
          j = "align_view_center";
          y = "align_view_top";
          x = "align_view_bottom";
          m = "align_view_middle";
          h = "scroll_down";
          down = "scroll_down";
          t = "scroll_up";
          up = "scroll_up";
          # C-u = "no_op";
          C-f = "page_down";
          pagedown = "page_down";
          C-x = "no_op";
          C-b = "page_up";
          pageup = "page_up";
          C-e = "no_op";
          C-d = "half_page_down";
          C-g = "no_op";
          C-u = "half_page_up";
        };

        # Goto mode
        i = {
          # Remove old
          "[" = "no_op";
          "]" = "no_op";
          "'" = "no_op";
          "," = "no_op";
          # "." = "no_op";
          # p = "no_op";
          # y = "no_op";
          # f = "no_op";
          g = "no_op";
          # c = "no_op";
          r = "no_op";
          # l = "no_op";
          "/" = "no_op";
          "=" = "no_op";
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
          s = "no_op";
          minus = "no_op";
          ";" = "no_op";
          q = "no_op";
          # j = "no_op";
          k = "no_op";
          # x = "no_op";
          # b = "no_op";
          # m = "no_op";
          w = "no_op";
          # v = "no_op";
          z = "no_op";
          "{" = "no_op";
          "}" = "no_op";
          "\"" = "no_op";
          "<" = "no_op";
          ">" = "no_op";
          P = "no_op";
          Y = "no_op";
          F = "no_op";
          C = "no_op";
          R = "no_op";
          L = "no_op";
          "?" = "no_op";
          "+" = "no_op";
          "|" = "no_op";
          A = "no_op";
          O = "no_op";
          E = "no_op";
          U = "no_op";
          I = "no_op";
          D = "no_op";
          H = "no_op";
          T = "no_op";
          N = "no_op";
          S = "no_op";
          "_" = "no_op";
          ":" = "no_op";
          Q = "no_op";
          J = "no_op";
          K = "no_op";
          X = "no_op";
          B = "no_op";
          M = "no_op";
          W = "no_op";
          V = "no_op";
          Z = "no_op";

          i = "goto_file_start";
          "." = "goto_last_line";
          u = "goto_file";
          d = "goto_line_start";
          n = "goto_line_end";
          o = "goto_first_nonwhitespace";
          y = "goto_window_top";
          j = "goto_window_center";
          x = "goto_window_bottom";
          e = "goto_definition";
          f = "goto_type_definition";
          p = "goto_reference";
          c = "goto_implementation";
          a = "goto_last_accessed_file";
          m = "goto_last_modified_file";
          b = "goto_next_buffer";
          l = "goto_previous_buffer";
          v = "goto_last_modification";
          h = "move_line_down";
          t = "move_line_up";
        };

        # Match mode
        m = {
          # Remove old
          "[" = "no_op";
          "]" = "no_op";
          "'" = "no_op";
          "," = "no_op";
          "." = "no_op";
          # p = "no_op";
          y = "no_op";
          f = "no_op";
          g = "no_op";
          # c = "no_op";
          r = "no_op";
          l = "no_op";
          "/" = "no_op";
          "=" = "no_op";
          "\\" = "no_op";
          # a = "no_op";
          # o = "no_op";
          # e = "no_op";
          u = "no_op";
          i = "no_op";
          d = "no_op";
          h = "no_op";
          t = "no_op";
          n = "no_op";
          s = "no_op";
          minus = "no_op";
          ";" = "no_op";
          q = "no_op";
          j = "no_op";
          k = "no_op";
          x = "no_op";
          b = "no_op";
          # m = "no_op";
          w = "no_op";
          v = "no_op";
          z = "no_op";
          "{" = "no_op";
          "}" = "no_op";
          "\"" = "no_op";
          "<" = "no_op";
          ">" = "no_op";
          P = "no_op";
          Y = "no_op";
          F = "no_op";
          C = "no_op";
          R = "no_op";
          L = "no_op";
          "?" = "no_op";
          "+" = "no_op";
          "|" = "no_op";
          A = "no_op";
          O = "no_op";
          E = "no_op";
          U = "no_op";
          I = "no_op";
          D = "no_op";
          H = "no_op";
          T = "no_op";
          N = "no_op";
          S = "no_op";
          "_" = "no_op";
          ":" = "no_op";
          Q = "no_op";
          J = "no_op";
          K = "no_op";
          X = "no_op";
          B = "no_op";
          M = "no_op";
          W = "no_op";
          V = "no_op";
          Z = "no_op";

          m = "match_brackets";
          o = "surround_add";
          p = "surround_replace";
          e = "surround_delete";
          a = "select_textobject_around";
          c = "select_textobject_inner";
        };

        # Window mode
        "C-," = "no_op";
        C-w = {
          # Remove old
          "[" = "no_op";
          "]" = "no_op";
          # "'" = "no_op";
          # "," = "no_op";
          "." = "no_op";
          p = "no_op";
          # y = "no_op";
          f = "no_op";
          g = "no_op";
          c = "no_op";
          # r = "no_op";
          l = "no_op";
          "/" = "no_op";
          "=" = "no_op";
          "\\" = "no_op";
          a = "no_op";
          # o = "no_op";
          e = "no_op";
          # u = "no_op";
          i = "no_op";
          # d = "no_op";
          # h = "no_op";
          t = "no_op";
          # n = "no_op";
          s = "no_op";
          minus = "no_op";
          ";" = "no_op";
          q = "no_op";
          j = "no_op";
          # k = "no_op";
          x = "no_op";
          b = "no_op";
          m = "no_op";
          w = "no_op";
          v = "no_op";
          z = "no_op";
          "{" = "no_op";
          "}" = "no_op";
          "\"" = "no_op";
          "<" = "no_op";
          ">" = "no_op";
          P = "no_op";
          Y = "no_op";
          F = "no_op";
          C = "no_op";
          R = "no_op";
          L = "no_op";
          "?" = "no_op";
          "+" = "no_op";
          "|" = "no_op";
          A = "no_op";
          O = "no_op";
          E = "no_op";
          # U = "no_op";
          I = "no_op";
          # D = "no_op";
          # H = "no_op";
          # T = "no_op";
          # N = "no_op";
          S = "no_op";
          "_" = "no_op";
          ":" = "no_op";
          Q = "no_op";
          J = "no_op";
          K = "no_op";
          X = "no_op";
          B = "no_op";
          M = "no_op";
          W = "no_op";
          V = "no_op";
          Z = "no_op";

          "C-," = "no_op";
          C-w = "rotate_view";
          "," = "rotate_view";
          # C-k = "no_op";
          C-v = "vsplit";
          k = "vsplit";
          # C-o = "no_op";
          C-s = "hsplit";
          o = "hsplit";
          u = "goto_file";
          U = "goto_file";
          C-d = "no_op";
          C-h = "jump_view_left";
          d = "jump_view_left";
          left = "jump_view_left";
          # C-h = "no_op";
          C-j = "jump_view_down";
          h = "jump_view_down";
          down = "jump_view_down";
          C-t = "no_op";
          C-k = "jump_view_up";
          y = "jump_view_up";
          up = "jump_view_up";
          C-n = "no_op";
          C-l = "jump_view_right";
          n = "jump_view_right";
          right = "jump_view_right";
          "C-'" = "no_op";
          C-q = "wclose";
          "'" = "wclose";
          C-r = "no_op";
          C-o = "wonly";
          r = "wonly";
          D = "swap_view_left";
          H = "swap_view_down";
          T = "swap_view_up";
          N = "swap_view_right";
        };
        space = {
          # Remove old
          "[" = "no_op";
          "]" = "no_op";
          "'" = "no_op";
          # "," = "no_op";
          "." = "no_op";
          # p = "no_op";
          y = "no_op";
          # f = "no_op";
          g = "no_op";
          c = "no_op";
          r = "no_op";
          # l = "no_op";
          "/" = "no_op";
          "=" = "no_op";
          "\\" = "no_op";
          # a = "no_op";
          # o = "no_op";
          # e = "no_op";
          # u = "no_op";
          # i = "no_op";
          # d = "no_op";
          # h = "no_op";
          # t = "no_op";
          n = "no_op";
          s = "no_op";
          # minus = "no_op";
          ";" = "no_op";
          q = "no_op";
          j = "no_op";
          k = "no_op";
          # x = "no_op";
          b = "no_op";
          m = "no_op";
          w = "no_op";
          v = "no_op";
          # z = "no_op";
          "{" = "no_op";
          "}" = "no_op";
          "\"" = "no_op";
          "<" = "no_op";
          ">" = "no_op";
          # P = "no_op";
          Y = "no_op";
          # F = "no_op";
          C = "no_op";
          R = "no_op";
          # L = "no_op";
          "?" = "no_op";
          "+" = "no_op";
          "|" = "no_op";
          A = "no_op";
          # O = "no_op";
          # E = "no_op";
          # U = "no_op";
          I = "no_op";
          D = "no_op";
          H = "no_op";
          T = "no_op";
          N = "no_op";
          S = "no_op";
          "_" = "no_op";
          ":" = "no_op";
          Q = "no_op";
          J = "no_op";
          K = "no_op";
          X = "no_op";
          B = "no_op";
          M = "no_op";
          W = "no_op";
          V = "no_op";
          # Z = "no_op";

          u = "file_picker";
          U = "file_picker_in_current_directory";
          x = "buffer_picker";
          h = "jumplist_picker";
          i = "no_op";
          t = "hover";
          o = "symbol_picker";
          O = "workspace_symbol_picker";
          e = "diagnostics_picker";
          E = "workspace_diagnostics_picker";
          p = "rename_symbol";
          a = "code_action";
          d = "select_references_to_symbol_under_cursor";
          minus = "last_picker";
          "," = {
            # Remove old
            "[" = "no_op";
            "]" = "no_op";
            # "'" = "no_op";
            # "," = "no_op";
            "." = "no_op";
            p = "no_op";
            # y = "no_op";
            f = "no_op";
            g = "no_op";
            c = "no_op";
            # r = "no_op";
            l = "no_op";
            "/" = "no_op";
            "=" = "no_op";
            "\\" = "no_op";
            a = "no_op";
            # o = "no_op";
            e = "no_op";
            # u = "no_op";
            i = "no_op";
            # d = "no_op";
            # h = "no_op";
            t = "no_op";
            # n = "no_op";
            s = "no_op";
            minus = "no_op";
            ";" = "no_op";
            q = "no_op";
            j = "no_op";
            # k = "no_op";
            x = "no_op";
            b = "no_op";
            m = "no_op";
            w = "no_op";
            v = "no_op";
            z = "no_op";
            "{" = "no_op";
            "}" = "no_op";
            "\"" = "no_op";
            "<" = "no_op";
            ">" = "no_op";
            P = "no_op";
            Y = "no_op";
            F = "no_op";
            C = "no_op";
            R = "no_op";
            L = "no_op";
            "?" = "no_op";
            "+" = "no_op";
            "|" = "no_op";
            A = "no_op";
            O = "no_op";
            E = "no_op";
            # U = "no_op";
            I = "no_op";
            # D = "no_op";
            # H = "no_op";
            # T = "no_op";
            # N = "no_op";
            S = "no_op";
            "_" = "no_op";
            ":" = "no_op";
            Q = "no_op";
            J = "no_op";
            K = "no_op";
            X = "no_op";
            B = "no_op";
            M = "no_op";
            W = "no_op";
            V = "no_op";
            Z = "no_op";

            "C-," = "no_op";
            C-w = "rotate_view";
            "," = "rotate_view";
            # C-k = "no_op";
            C-v = "vsplit";
            k = "vsplit";
            # C-o = "no_op";
            C-s = "hsplit";
            o = "hsplit";
            u = "goto_file";
            U = "goto_file";
            C-d = "no_op";
            C-h = "jump_view_left";
            d = "jump_view_left";
            left = "jump_view_left";
            # C-h = "no_op";
            C-j = "jump_view_down";
            h = "jump_view_down";
            down = "jump_view_down";
            C-t = "no_op";
            C-k = "jump_view_up";
            y = "jump_view_up";
            up = "jump_view_up";
            C-n = "no_op";
            C-l = "jump_view_right";
            n = "jump_view_right";
            right = "jump_view_right";
            "C-'" = "no_op";
            C-q = "wclose";
            "'" = "wclose";
            C-r = "no_op";
            C-o = "wonly";
            r = "wonly";
            D = "swap_view_left";
            H = "swap_view_down";
            T = "swap_view_up";
            N = "swap_view_right";
          };
          l = "paste_clipboard_after";
          L = "paste_clipboard_before";
          f = "yank_joined_to_clipboard";
          F = "yank_main_selection_to_clipboard";
          P = "replace_selections_with_clipboard";
          z = "global_search";
          Z = "command_palette";
        };
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
      };
      keys.insert = {
        esc = "normal_mode";
        C-o = "no_op";
        C-s = "commit_undo_checkpoint";
        C-q = "no_op";
        C-x = "completion";
        C-p = "no_op";
        C-r = "insert_register";
        "C-," = "no_op";
        C-w = "delete_word_backward";
        # A-backspace = "no_op";
        A-backspace = "delete_word_backward";
        A-e = "no_op";
        A-d = "delete_word_forward";
        # A-del = "no_op";
        A-del = "delete_word_forward";
        C-g = "no_op";
        C-u = "kill_to_line_start";
        C-t = "no_op";
        C-k = "kill_to_line_end";
        # C-d = "no_op";
        C-h = "delete_char_backward";
        backspace = "delete_char_backward";
        S-backspace = "delete_char_backward";
        C-e = "no_op";
        C-d = "delete_char_forward";
        del = "delete_char_forward";
        # C-h = "no_op";
        C-j = "insert_newline";
        ret = "insert_newline";
        up = "move_line_up";
        down = "move_line_down";
        left = "move_char_left";
        right = "move_char_right";
        pageup = "page_up";
        pagedown = "page_down";
        home = "goto_line_start";
        end = "goto_line_end_newline";
      };
    };
  };
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      lualine-nvim
      nvim-web-devicons
      nvim-tree-lua
      nvim-treesitter.withAllGrammars
      comment-nvim
      nvim-lspconfig
      nvim-cmp
      luasnip
      cmp_luasnip
      friendly-snippets
      cmp-nvim-lsp
      telescope-nvim
      plenary-nvim
      formatter-nvim
      nvim-autopairs
      indent-blankline-nvim
      trouble-nvim
      harpoon
      nvim-jdtls
      # # # coc
      # coc-java
      # coc-sumneko-lua
      # coc-json
      # coc-python
    ];
    extraPackages = with pkgs; [
      # # Language Servers
      lua-language-server
      clang-tools # Also a formatter
      nodePackages.bash-language-server
      nodePackages.pyright
      nil
      jdt-language-server
      # # Formatters
      stylua
      yapf
      shfmt
      alejandra
      # google-java-format
    ];
    # coc = {
    #   enable = true;
    #   settings = {
    #     # "coc.preferences.snippets.enable" = true;
    #     "coc.preferences.extensionUpdateCheck" = "never";
    #     "sumneko-lua.serverDir" = "${pkgs.lua-language-server}/bin/lua-language-server";
    #   };
    #
    #
    # };
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
