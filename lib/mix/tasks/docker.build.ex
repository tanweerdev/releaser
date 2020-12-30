# ./lib/mix/tasks/docker.build.ex
defmodule Mix.Tasks.Docker.Build do
  use Mix.Task

  @shortdoc "Docker utilities for building releases"
  def run(args) do
    Mix.Tasks.Docker.run(args)
  end
end
