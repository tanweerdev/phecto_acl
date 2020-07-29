defmodule PhEctoAcl.PermissionSystem do
  def table_level_permissions(user_id, method, table_name, options) do
    # TODO: require options and raise errors if nil
    user_role_agent = options[:user_role_agent]
    table_action_agent = options[:table_action_agent]
    role_table_action_agent = options[:role_table_action_agent]

    record_tuple =
      Enum.find(table_action_agent.get(), fn {k, _v} -> k == [method, table_name] end)

    if is_nil(record_tuple) do
      "method or table name is incorrect"
    else
      {_list, table_action} = record_tuple

      role_ids = user_roles(user_id, user_role_agent: user_role_agent)

      Enum.any?(role_table_action_agent.get(), fn role_table_action ->
        role_table_action.role_id in role_ids &&
          role_table_action.table_action_id == table_action.id
      end)
    end
  end

  def route_level_permissions(user_id, http_method, path, options) do
    # TODO: require options and raise errors if nil
    user_role_agent = options[:user_role_agent]
    route_action_agent = options[:route_action_agent]
    role_route_action_agent = options[:role_route_action_agent]
    record_tuple = Enum.find(route_action_agent.get(), fn {k, _v} -> k == [http_method, path] end)

    if is_nil(record_tuple) do
      "http verb or path is incorrect"
    else
      {_list, route_action} = record_tuple

      role_ids = user_roles(user_id, user_role_agent: user_role_agent)

      Enum.any?(role_route_action_agent.get(), fn role_route_action ->
        role_route_action.role_id in role_ids &&
          role_route_action.route_action_id == route_action.id
      end)
    end
  end

  def user_roles(user_id, user_role_agent: user_role_agent) do
    # user_role_agent_child = %{
    #   id: PhEctoAcl.UserRoleAgent,
    #   start: {PhEctoAcl.UserRoleAgent, :start_link, [[repo: HaiData.Repo]]}
    # }

    # DynamicSupervisor.start_child(PhEctoAcl.DynamicSupervisor, user_role_agent_child)

    Enum.reduce(user_role_agent.get(), [], fn user_role, acc ->
      if user_role.user_id == user_id do
        acc ++ [user_role.role_id]
      else
        acc
      end
    end)
  end

  def router_path(conn) do
    Enum.reduce(conn.path_params, conn.path_info, fn {key, value}, acc ->
      index = Enum.find_index(acc, fn x -> x == value end)
      List.replace_at(acc, index, ":#{key}")
    end)
  end
end
