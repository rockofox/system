{ pkgs, colorScheme, font, sensitive, ... }: {
  config.programs.firefox.profiles.default.userChrome = ''
    :root {
        --toolbar-bgcolor: #${colorScheme.palette.base01};
        color: #${colorScheme.palette.base05};
    }

    menubar, toolbar, nav-bar, #TabsToolbar > *{
        background-color: #${colorScheme.palette.base00};
        color: #${colorScheme.palette.base05};
    }

  '';

  config.home.file.obsidian-base16ng = {
    target = "${sensitive.lib.obsidianVault}/.obsidian/snippets/base16ng.css";
    text = ''

      :root {
        --base00: #${colorScheme.palette.base00};
        --base01: #${colorScheme.palette.base01};
        --base02: #${colorScheme.palette.base02};
        --base03: #${colorScheme.palette.base03};
        --base04: #${colorScheme.palette.base04};
        --base05: #${colorScheme.palette.base05};
        --base06: #${colorScheme.palette.base06};
        --base07: #${colorScheme.palette.base07};
        --base08: #${colorScheme.palette.base08};
        --base09: #${colorScheme.palette.base09};
        --base0A: #${colorScheme.palette.base0A};
        --base0B: #${colorScheme.palette.base0B};
        --base0C: #${colorScheme.palette.base0C};
        --base0D: #${colorScheme.palette.base0D};
        --base0E: #${colorScheme.palette.base0E};
        --base0F: #${colorScheme.palette.base0F};
      }

      /*************************
      * Font selection
      *************************/

      .workspace {
        font-family: var(--font-family-editor);
      }

      .markdown-preview-view {
        font-family: var(--font-family-preview) !important;
      }

      /*************************
      * workspace
      *************************/

      .workspace {
        color: var(--base06) !important;
        background-color: var(--base00) !important;
      }

      .workspace-tabs {
        color: var(--base06) !important;
        background-color: var(--base00) !important;
      }

      .workspace-tab-header {
        color: var(--base06) !important;
        background-color: var(--base00) !important;
      }

      .workspace-tab-header-inner {
        color: var(--base02) !important;
      }

      .workspace-leaf {
        color: var(--base06) !important;
        background-color: var(--base00) !important;
      }

      /*************************
      * View header
      *************************/

      .view-header {
        background-color: var(--base00) !important;
        color: var(--base06) !important;
        border-bottom: 1px solid var(--base01);
      }

      .view-header-title {
        color: var(--base06) !important;
      }

      .view-header-title-container:after {
        background: none !important;
      }

      .view-content {
        background-color: var(--base00) !important;
        color: var(--base06) !important;
      }

      .view-action {
        color: var(--base06) !important;
      }

      /*************************
      * Nav folder
      *************************/

      .nav-folder-title, .nav-file-title {
        background-color: var(--base00) !important;
        color: var(--base06) !important;
      }

      .nav-action-button {
        color: var(--base06) !important;
      }

      /*************************
      * Markdown headers
      *************************/

      .cm-header-1, .markdown-preview-view h1 {
        color: var(--base0A);
      }

      .cm-header-2, .markdown-preview-view h2 {
        color: var(--base0B);
      }

      .cm-header-3, .markdown-preview-view h3 {
        color: var(--base0C);
      }

      .cm-header-4, .markdown-preview-view h4 {
        color: var(--base0D);
      }

      .cm-header-5, .markdown-preview-view h5 {
        color: var(--base0E);
      }

      .cm-header-6, .markdown-preview-view h6 {
        color: var(--base0E);
      }

      /*************************
      * Markdown strong and emphasis
      *************************/

      .cm-em, .markdown-preview-view em {
        color: var(--base0D);
      }

      .cm-strong, .markdown-preview-view strong {
        color: var(--base09);
      }

      /*************************
      * Markdown links
      *************************/

      .cm-link, .markdown-preview-view a {
        color: var(--base0C) !important;
      }

      .cm-formatting-link,.cm-url {
        color: var(--base03) !important;
      }

      /*************************
      * Quotes
      *************************/

      .cm-quote, .markdown-preview-view blockquote {
        color: var(--base0D) !important;
      }

      /*************************
      * Code blocks
      *************************/

      .HyperMD-codeblock, .markdown-preview-view pre {
        color: var(--base07) !important;
        background-color: var(--base01) !important;
      }

      .cm-inline-code, .markdown-preview-view code {
        color: var(--base07) !important;
        background-color: var(--base01) !important;
      }

      /*************************
      * Cursor
      *************************/

      .CodeMirror-cursors {
        color: var(--base0B);
        z-index: 5 !important /* fixes a bug where cursor is hidden in code blocks */
      }
    '';
  };
  config.home.file.obsidian-highland = {
    target = "${sensitive.lib.obsidianVault}/.obsidian/snippets/highland.css";
    text = ''
      /*- source+live preview mode font -*/
      .markdown-source-view.mod-cm6 .cm-scroller {
        font-family: 'Courier Prime Sans';
        font-size: 22px;
      }

      /*- reading mode font -*/
      .markdown-preview-view {
        font-family: 'Bookerly';
        font-size: 22px;
        text-align: justify;
        text-justify: inter-word;
      }

      .cm-scroller {
        font-family: 'Bookerly';
        font-size: 22px;
      }

      /*- Remove spaces and add indents between paragraphs in reading mode -*/
      .markdown-preview-view p {
        margin-top: 0em;
        margin-bottom: 0em;
        text-indent: 1em;
      }
    '';
  };
  config.home.file.obsidian-base16 = {
    target = "${sensitive.lib.obsidianVault}/.obsidian/snippets/base16.css";
    text = ''
      .theme-dark {
        --background-primary: #${colorScheme.palette.base00};
        --background-primary-alt: #${colorScheme.palette.base01};
        --background-secondary: #${colorScheme.palette.base01};
        --background-secondary-alt: #${colorScheme.palette.base01};
        --background-accent: #000;
        --background-modifier-border: #424958;
        --background-modifier-form-field: rgba(0, 0, 0, 0.3);
        --background-modifier-form-field-highlighted: rgba(0, 0, 0, 0.22);
        --background-modifier-box-shadow: rgba(0, 0, 0, 0.3);
        --background-modifier-success: #539126;
        --background-modifier-error: #3d0000;
        --background-modifier-error-rgb: 61, 0, 0;
        --background-modifier-error-hover: #470000;
        --background-modifier-cover: rgba(0, 0, 0, 0.6);
        --text-accent: #${colorScheme.palette.base08};
        --text-accent-hover: #${colorScheme.palette.base09};
        --text-normal: #${colorScheme.palette.base05};
        --text-muted: #${colorScheme.palette.base04};
        --text-faint: #${colorScheme.palette.base04};
        --text-error: #e16d76;
        --text-error-hover: #c9626a;
        --text-highlight-bg: rgba(255, 255, 0, 0.4);
        --text-selection: rgba(0, 122, 255, 0.2);
        --text-on-accent: #dcddde;
        --interactive-normal: #20242b;
        --interactive-hover: #353b47;
        --interactive-accent: #4c78cc;
        --interactive-accent-rgb: 76, 120, 204;
        --interactive-accent-hover: #5082df;
        --scrollbar-active-thumb-bg: rgba(255, 255, 255, 0.2);
        --scrollbar-bg: rgba(255, 255, 255, 0.05);
        --scrollbar-thumb-bg: rgba(255, 255, 255, 0.1);
        --panel-border-color: #18191e;
        --gray-1: #5C6370;
        --gray-2: #abb2bf;
        --red: #e06c75;
        --orange: #d19a66;
        --green: #98c379;
        --aqua: #56b6c2;
        --purple: #c678dd;
        --blue: #61afef;
        --yellow: #e5c07b;
        --code-background: #${colorScheme.palette.base00};
        --code-normal: #${colorScheme.palette.base05};
        --code-comment: #${colorScheme.palette.base03};
        --code-function: #${colorScheme.palette.base0D};
        --code-important: #${colorScheme.palette.base06};
        --code-keyword: #${colorScheme.palette.base0E};
        --code-operator: #${colorScheme.palette.base05};
        --code-property: #${colorScheme.palette.base0C};
        --code-punctuation: #${colorScheme.palette.base05};
        --code-string: #${colorScheme.palette.base0B};
        --code-tag: #${colorScheme.palette.base0A};
        --code-value: #${colorScheme.palette.base09};
        --status-bar-border-width: 0;
      }

      .mod-header {
        display: none;
      }
      .obsidian-banner-wrapper:has(img:not([src])) {
        display: none;
      }
    '';
  };

  config.home.file.obisidan-dashboard = {
    target = "${sensitive.lib.obsidianVault}/.obsidian/snippets/dashboard.css";
    text = ''
      /* Dashboard */
      /* Updated 2023-08-07 */

      .dashboard {
        padding-left: 12px !important;
        padding-right: 12px !important;
        padding-top: 20px !important;
      }

      .dashboard .markdown-preview-section {
        max-width: 100%;
      }

      /* Title at top of the document */
      .dashboard .markdown-preview-section .title {
        top: 60px;
        position: absolute;
        font-size: 26pt !important;
        font-weight: bolder;
        letter-spacing: 8px;
      }

      .dashboard h1 {
        border-bottom-style: dotted !important;
        border-width: 1px !important;
        padding-bottom: 3px !important;
      }


      /* Get rid of the parent bullet */
      .dashboard div.markdown-preview-section > div > ul > li > div.list-bullet {
        display: none !important;
      }

      /* Remove the indentation guide lines */
      .dashboard.markdown-rendered.show-indentation-guide li > ul::before,
      .dashboard.markdown-rendered.show-indentation-guide li > ol::before {
        display: none;
      }

      div.markdown-preview-section > div > ul.has-list-bullet > li {
        padding-left: 0p !important;
      }

      .dashboard div > ul {
        list-style: none;
        display: flex;
        column-gap: 50px;
        flex-flow: row wrap;
      }

      .dashboard div > ul > li {
        min-width: 250px;
        width: 15%;
      }

      /* Dataview support */
      .dashboard ul.dataview {
        row-gap: 0px !important;
        list-style-type: disc !important;
      }
    '';
  };
  # config.colorScheme.rose-pine-moon = {
  #   slug = "rose-pine-moon";
  #   name = "Rose Pine Moon";
  #   colors = {
  #     base00 = "232136";
  #     base01 = "2a273f";
  #     base02 = "393552";
  #     base03 = "6e6a86";
  #     base04 = "908caa";
  #     base05 = "e0def4";
  #     base06 = "e0def4";
  #     base07 = "56526e";
  #     base08 = "ecebf0";
  #     # base08 = "eb6f92";
  #     base09 = "f6c177";
  #     base0A = "ea9a97";
  #     base0B = "3e8fb0";
  #     base0C = "9ccfd8";
  #     base0D = "c4a7e7";
  #     base0E = "f6c177";
  #     base0F = "56526e";
  #   };
  # };
  # pasque = {
  #   slug = "pasque";
  #   name = "Pasque";
  #   author = "Gabriel Fontes (https://github.com/Misterio77)";
  #   colors = {
  #     base00 = "271C3A";
  #     base01 = "100323";
  #     base02 = "3E2D5C";
  #     base03 = "5D5766";
  #     base04 = "BEBCBF";
  #     base05 = "DEDCDF";
  #     base06 = "EDEAEF";
  #     base07 = "BBAADD";
  #     base08 = "A92258";
  #     base09 = "918889";
  #     base0A = "804ead";
  #     base0B = "C6914B";
  #     base0C = "7263AA";
  #     base0D = "8E7DC6";
  #     base0E = "953B9D";
  #     base0F = "59325C";
  #   };
  # };
  # doomVibrant = {
  #   slug = "doom-vibrant";
  #   name = "Doom Vibrant";
  #   author = "Henrik Lissner <https://github.com/hlissner>";
  #   colors = {
  #     base00 = "2E3440";
  #     base01 = "3B4252";
  #     base02 = "434C5E";
  #     base03 = "4C566A";
  #     base04 = "D8DEE9";
  #     base05 = "E5E9F0";
  #     base06 = "ECEFF4";
  #     base07 = "8FBCBB";
  #     base08 = "BF616A";
  #     base09 = "D08770";
  #     base0A = "EBCB8B";
  #     base0B = "A3BE8C";
  #     base0C = "88C0D0";
  #     base0D = "81A1C1";
  #     base0E = "B48EAD";
  #     base0F = "5E81AC";
  #   };
  # };
  # darcula = {
  #   slug = "darcula";
  #   name = "Darcula";
  #   author = "jetbrains";
  #   colors = {
  #     base00 = "1a1a1a"; # background
  #     base01 = "323232"; # line cursor
  #     base02 = "323232"; # statusline
  #     base03 = "606366"; # line numbers
  #     base04 = "a4a3a3"; # selected line number
  #     base05 = "a9b7c6"; # foreground
  #     base06 = "ffc66d"; # function bright yellow
  #     base07 = "ffffff";
  #     base08 = "4eade5"; # cyan
  #     base09 = "689757"; # blue
  #     base0A = "bbb529"; # yellow
  #     base0B = "6a8759"; # string green
  #     base0C = "629755"; # comment green
  #     base0D = "9876aa"; # purple
  #     base0E = "cc7832"; # orange
  #     base0F = "808080"; # gray
  #   };
  # };
  # monokai-spectrum = {
  #   slug = "darcula-spectrum";
  #   name = "Darcula Filter Spectrum";
  #   author = "jetbrains";
  #   colors = {
  #     base00 = "1f1f1f";
  #     base01 = "383830";
  #     base02 = "49483e";
  #     base03 = "75715e";
  #     base04 = "a59f85";
  #     base05 = "f8f8f2";
  #     base06 = "f5f4f1";
  #     base07 = "f9f8f5";
  #     base08 = "f92672";
  #     base09 = "fd971f";
  #     base0A = "f4bf75";
  #     base0B = "a6e22e";
  #     base0C = "a1efe4";
  #     base0D = "66d9ef";
  #     base0E = "ae81ff";
  #     base0F = "cc6633";
  #   };
  # };
}
