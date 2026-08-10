-- [[ LSP configuration for the scala language server ]]
--
-- Requirements: metals must be on your $PATH, probably installed using coursier

return {
  cmd = { 'metals' },
  filetypes = { 'scala' },
  root_markers = {
    '.git',
    { 'pom.xml', 'build.sbt', 'build.sc', 'build.gradle', 'build.gradle.kts' },
  },
  settings = {
    metals = {
      sbtScript = "/home/chud/git/wilhelmagren/spark/build/sbt",
    },
  },
  init_options = {
    statusBarProvider = 'show-message',
    isHttpEnabled = true,
    compilerOptions = {
      snippetAutoIndent = false,
    },
  },
  capabilities = {
    workspace = {
      configuration = false,
    },
  },
}
