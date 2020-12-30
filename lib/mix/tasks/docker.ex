# ./lib/mix/tasks/docker.ex
defmodule Mix.Tasks.Docker do
  use Mix.Task

  @shortdoc "Docker utilities for building releases"
  def run([env]) do
    run([env, "elixir_build"])
  end
  def run([env, app_name]) do
    # Build a fresh Elixir image, in case Dockerfile has changed
    build_image(env, app_name)

    # Get the current working directory
    {dir, _resp} = System.cmd("pwd", [])

    # List down whats inside image
    # docker(
    #   "run -v #{String.trim(dir)}:/opt/build #{app_name}:latest ls /opt/"
    # )


    # Mount the working directory at /opt/build within the new elixir image
    # Execute the /opt/build/bin/release.sh script
    docker(
      "run -v #{String.trim(dir)}:/opt/build --rm -i #{app_name}:latest ./apps/releaser/bin/release.sh #{env}"
    )
  end

  defp build_image(env, app_name) do
    docker("build --build-arg ENV=#{env} -t #{app_name}:latest .")
  end

  defp docker(cmd) do
    System.cmd("docker", String.split(cmd, " "), into: IO.stream(:stdio, :line))
  end
end
