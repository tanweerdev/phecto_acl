defmodule ExAcl do
  @moduledoc false
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    # import Supervisor.Spec

    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: ExAcl.DynamicSupervisor}
    ]

    # dynamic example
    # user_role_agent_child = %{
    #   id: ExAcl.UserRoleAgent,
    #   start: {ExAcl.UserRoleAgent, :start_link, [[repo: HaiData.Repo]]}
    # }

    # DynamicSupervisor.start_child(ExAcl.DynamicSupervisor, user_role_agent_child)

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end