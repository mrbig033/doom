(map! (:map (python-mode-map)
            "M-p"              'my-backward-paragraph-do-indentation
            "M-n"              'my-forward-paragraph-do-indentation
            "C-c ç"            'my-python-shebang
            "C-ç"              'elpy-shell-switch-to-shell
            "M-a"              'python-nav-backward-statement
            "M-e"              'python-nav-forward-statement
            :n "<return>"      'hydra-python-mode/body
            :i "C-="           'my-python-colon-newline
            :nv "<"            'python-indent-shift-left
            :nv ">"            'python-indent-shift-right
            :nvig "<C-return>" 'my-quickrun)

      (:map (inferior-python-mode-map)
            "C-ç" 'my-elpy-switch-to-buffer
            :i "C-l" 'comint-clear-buffer))
