import Config

config :git_ops,
  mix_project: Mix.Project.get!(),
  changelog_file: "CHANGELOG.md",
  repository_url: "https://gitlab.com/jimsy/lamina_dashboard",
  manage_mix_version?: true,
  manage_readme_version: "README.md",
  version_tag_prefix: "v"

config :phoenix, :json_library, Jason