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
        --background-modifier-border: #${colorScheme.palette.base00};
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
        --ribbon-background: #${colorScheme.palette.base00};
        --titlebar-background: #${colorScheme.palette.base00};
        --tab-container-background: #${colorScheme.palette.base00};
        --bg1: #${colorScheme.palette.base00};
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
}
