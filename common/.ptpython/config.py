"""
Configuration example for ``ptpython``.

Copy this file to ~/.ptpython/config.py
"""
from __future__ import unicode_literals

# from prompt_toolkit.key_binding.input_processor import KeyPress
from prompt_toolkit.keys import Keys
from prompt_toolkit.styles.pygments import style_from_pygments_dict
from ptpython.layout import CompletionVisualisation
from pygments.token import (
    Keyword,
    Name,
    Comment,
    String,
    Error,
    Literal,
    Number,
    Operator,
    Other,
    Punctuation,
    Text,
    Generic,
    Whitespace,
)

__all__ = ("configure",)


def configure(repl):
    """REPL Configuration.

    This is called during the start-up of ptpython.

    :param repl: `PythonRepl` instance.
    """
    # Show function signature (bool).
    repl.show_signature = True

    # Show docstring (bool).
    repl.show_docstring = True

    # Show the "[Meta+Enter] Execute" message when pressing [Enter] only
    # inserts a newline instead of executing the code.
    repl.show_meta_enter_message = True

    # Show completions. (NONE, POP_UP, MULTI_COLUMN or TOOLBAR)
    repl.completion_visualisation = CompletionVisualisation.POP_UP

    # When CompletionVisualisation.POP_UP has been chosen, use this
    # scroll_offset in the completion menu.
    repl.completion_menu_scroll_offset = 0

    # Show line numbers (when the input contains multiple lines.)
    repl.show_line_numbers = True

    # Show status bar.
    repl.show_status_bar = True

    # When the sidebar is visible, also show the help text.
    repl.show_sidebar_help = True

    # Highlight matching parethesis.
    repl.highlight_matching_parenthesis = True

    # Line wrapping. (Instead of horizontal scrolling.)
    repl.wrap_lines = True

    # Mouse support.
    repl.enable_mouse_support = False

    # Complete while typing. (Don't require tab before the
    # completion menu is shown.)
    repl.complete_while_typing = False

    # Vi mode.
    repl.vi_mode = True

    # Paste mode. (When True, don't insert whitespace after new line.)
    repl.paste_mode = False

    # Use the classic prompt. (Display '>>>' instead of 'In [1]'.)
    repl.prompt_style = "ipython"  # 'classic' or 'ipython'

    # Don't insert a blank line after the output.
    repl.insert_blank_line_after_output = True

    # History Search.
    # When True, going back in history will filter the history on the records
    # starting with the current input. (Like readline.)
    # Note: When enable, please disable the `complete_while_typing` option.
    #       otherwise, when there is a completion available, the arrows will
    #       browse through the available completions instead of the history.
    repl.enable_history_search = True

    # Enable auto suggestions. (Pressing right arrow will complete the input,
    # based on the history.)
    repl.enable_auto_suggest = True

    # Enable open-in-editor. Pressing C-X C-E in emacs mode or 'v' in
    # Vi navigation mode will open the input in the current editor.
    repl.enable_open_in_editor = True

    # Enable system prompt. Pressing meta-! will display the system prompt.
    # Also enables Control-Z suspend.
    repl.enable_system_bindings = True

    # Ask for confirmation on exit.
    repl.confirm_exit = True

    # Enable input validation. (Don't try to execute when the input contains
    # syntax errors.)
    repl.enable_input_validation = True

    # Enable 24bit True color. (Not all terminals support this. -- maybe check
    # $TERM before changing.)
    repl.true_color = True

    # Use this colorscheme for the code.
    repl.install_code_colorscheme("dracula", style_from_pygments_dict(DRACULA_THEME))
    repl.install_code_colorscheme("one-dark", style_from_pygments_dict(ONE_DARK_THEME))
    repl.use_code_colorscheme("one-dark")

    # Add custom key binding for PDB.
    @repl.add_key_binding(Keys.ControlB)
    def _(event):
        """Pressing Control-B will insert 'pdb.set_trace()'."""
        event.cli.current_buffer.insert_text("\nimport pdb; pdb.set_trace()\n")

    # Typing ControlE twice should also execute the current command.
    # (Alternative for Meta-Enter.)
    @repl.add_key_binding(Keys.ControlE, Keys.ControlE)
    def _(event):
        b = event.current_buffer

        if b.accept_action.is_returnable:
            b.accept_action.validate_and_handle(event.cli, b)


DRACULA_THEME = {
    Comment: "#6272a4",
    Comment.Hashbang: "#6272a4",
    Comment.Multiline: "#6272a4",
    Comment.Preproc: "#ff79c6",
    Comment.Single: "#6272a4",
    Comment.Special: "#6272a4",
    Generic: "#f8f8f2",
    Generic.Deleted: "#8b080b",
    Generic.Emph: "#f8f8f2 underline",
    Generic.Error: "#f8f8f2",
    Generic.Heading: "#f8f8f2 bold",
    Generic.Inserted: "#f8f8f2 bold",
    Generic.Output: "#44475a",
    Generic.Prompt: "#f8f8f2",
    Generic.Strong: "#f8f8f2",
    Generic.Subheading: "#f8f8f2 bold",
    Generic.Traceback: "#f8f8f2",
    Error: "#f8f8f2",
    Keyword: "#ff79c6",
    Keyword.Constant: "#ff79c6",
    Keyword.Declaration: "#8be9fd italic",
    Keyword.Namespace: "#ff79c6",
    Keyword.Pseudo: "#ff79c6",
    Keyword.Reserved: "#ff79c6",
    Keyword.Type: "#8be9fd",
    Literal: "#f8f8f2",
    Literal.Date: "#f8f8f2",
    Name: "#f8f8f2",
    Name.Attribute: "#50fa7b",
    Name.Builtin: "#8be9fd italic",
    Name.Builtin.Pseudo: "#f8f8f2",
    Name.Class: "#50fa7b",
    Name.Constant: "#f8f8f2",
    Name.Decorator: "#f8f8f2",
    Name.Entity: "#f8f8f2",
    Name.Exception: "#f8f8f2",
    Name.Function: "#50fa7b",
    Name.Label: "#8be9fd italic",
    Name.Namespace: "#f8f8f2",
    Name.Other: "#f8f8f2",
    Name.Tag: "#ff79c6",
    Name.Variable: "#8be9fd italic",
    Name.Variable.Class: "#8be9fd italic",
    Name.Variable.Global: "#8be9fd italic",
    Name.Variable.Instance: "#8be9fd italic",
    Number: "#bd93f9",
    Number.Bin: "#bd93f9",
    Number.Float: "#bd93f9",
    Number.Hex: "#bd93f9",
    Number.Integer: "#bd93f9",
    Number.Integer.Long: "#bd93f9",
    Number.Oct: "#bd93f9",
    Operator: "#ff79c6",
    Operator.Word: "#ff79c6",
    Other: "#f8f8f2",
    Punctuation: "#f8f8f2",
    String: "#f1fa8c",
    String.Backtick: "#f1fa8c",
    String.Char: "#f1fa8c",
    String.Doc: "#f1fa8c",
    String.Double: "#f1fa8c",
    String.Escape: "#f1fa8c",
    String.Heredoc: "#f1fa8c",
    String.Interpol: "#f1fa8c",
    String.Other: "#f1fa8c",
    String.Regex: "#f1fa8c",
    String.Single: "#f1fa8c",
    String.Symbol: "#f1fa8c",
    Text: "#f8f8f2",
    Whitespace: "#f8f8f2",
}

# Refered from https://github.com/mgyongyosi/OneDarkJekyll/blob/master/syntax.less
ONE_DARK_THEME = {
    Comment: "#5c6370 italic",  # mono-3
    Comment.Hashbang: "#5c6370 italic",  # mono-3
    Comment.Multiline: "#5c6370 italic",  # mono-3
    Comment.Preproc: "#5c6370 italic",  # mono-3
    Comment.Single: "#5c6370 italic",  # mono-3
    Comment.Special: "#5c6370 italic",  # mono-3
    Generic: "#abb2bf",  # mono-1
    Generic.Deleted: "#8b080b",
    Generic.Emph: "#abb2bf italic",  # mono-1
    # Generic.Error: "#f8f8f2",
    # Generic.Heading: "#f8f8f2 bold",
    Generic.Inserted: "#43d08a",
    # Generic.Output: "#44475a",
    # Generic.Prompt: "#f8f8f2",
    Generic.Strong: "#abb2bf bold",  # mono-1
    Generic.Subheading: "#75715e",
    # Generic.Traceback: "#f8f8f2",
    Error: "#ffffff bg:#e05252",
    Keyword: "#c678dd",  # hue-3
    Keyword.Constant: "#c678dd",  # hue-3
    Keyword.Declaration: "#c678dd",  # hue-3
    Keyword.Namespace: "#c678dd",  # hue-3
    Keyword.Pseudo: "#c678dd",  # hue-3
    Keyword.Reserved: "#c678dd",  # hue-3
    Keyword.Type: "#c678dd",  # hue-3
    Literal: "#98c379",  # hue-4
    Literal.Date: "#98c379",  # hue-4
    Literal.String: "#98c379",  # hue-4
    Literal.Number: "#d19a66",  # hue-6
    Literal.Number.Float: "#d19a66",  # hue-6
    Literal.Number.Hex: "#d19a66",  # hue-6
    Literal.Number.Integer: "#d19a66",  # hue-6
    Literal.Number.Integer.Long: "#d19a66",  # hue-6
    Literal.Number.Oct: "#d19a66",  # hue-6
    Literal.String.Backtick: "#98c379",  # hue-4
    Literal.String.Char: "#98c379",  # hue-4
    Literal.String.Doc: "#98c379",  # hue-4
    Literal.String.Double: "#98c379",  # hue-4
    Literal.String.Escape: "#98c379",  # hue-4
    Literal.String.Heredoc: "#98c379",  # hue-4
    Literal.String.Interpol: "#98c379",  # hue-4
    Literal.String.Other: "#98c379",  # hue-4
    Literal.String.Regex: "#56b6c2",  # hue-1
    Literal.String.Single: "#98c379",  # hue-4
    Literal.String.Symbol: "#56b6c2",  # hue-1
    Name: "#abb2bf",  # mono-1  # mono-1
    Name.Attribute: "#d19a66",  # hue-6
    Name.Builtin: "#e5c07b",  # hue-6-2
    Name.Builtin.Pseudo: "#f8f8f2",
    Name.Class: "#e5c07b",  # hue-6-2
    Name.Constant: "#e5c07b",  # hue-6-2
    Name.Decorator: "#e5c07b",  # hue-6-2
    Name.Entity: "#e5c07b",  # hue-6-2
    Name.Exception: "#e5c07b",  # hue-6-2
    Name.Function: "#8be9fd",  # mono-1
    Name.Label: "#e5c07b",  # hue-6-2
    Name.Namespace: "#abb2bf",  # mono-1
    Name.Other: "#abb2bf",  # mono-1
    Name.Property: "#e5c07b",  # hule-6-2
    Name.Tag: "#e06c75",  # hue-5
    Name.Variable: "#e5c07b",  # hule-6-2
    Name.Variable.Class: "#8be9fd italic",
    Name.Variable.Global: "#8be9fd italic",
    Name.Variable.Instance: "#8be9fd italic",
    Number: "#bd93f9",
    Number.Bin: "#bd93f9",
    Number.Float: "#bd93f9",
    Number.Hex: "#bd93f9",
    Number.Integer: "#bd93f9",
    Number.Integer.Long: "#bd93f9",
    Number.Oct: "#bd93f9",
    Operator: "#abb2bf",  # mono-1
    Operator.Word: "#abb2bf bold",  # mono-1
    Other: "#abb2bf",  # mono-1
    Punctuation: "#abb2bf",  # mono-1
    # String: "#f1fa8c",
    # String.Backtick: "#f1fa8c",
    # String.Char: "#f1fa8c",
    # String.Doc: "#f1fa8c",
    # String.Double: "#f1fa8c",
    # String.Escape: "#f1fa8c",
    # String.Heredoc: "#f1fa8c",
    # String.Interpol: "#f1fa8c",
    # String.Other: "#f1fa8c",
    # String.Regex: "#f1fa8c",
    # String.Single: "#f1fa8c",
    # String.Symbol: "#f1fa8c",
    Text: "#f8f8f2",
    Text.Whitespace: "#f8f8f2",
    Whitespace: "#f8f8f2",
}
