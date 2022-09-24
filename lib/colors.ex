defmodule Colors do
  def left do
    spawn( fn ->
      left_server = self() 
      left_num([:red, :yellow, :blue, :black, :white, :brown, :green, :purple, :orange, :pink], left_server, [], [], 0, 0) end)
  end

  def right do
    spawn( fn ->
      right_server = self() 
      right_num([:red, :yellow, :blue, :black, :white, :brown, :green, :purple, :orange, :pink], [], right_server, [], 0, 0) end)
  end

  def judge do
    spawn(fn -> 
      judge_server = self() 
      judge_num([:red, :yellow, :blue, :black, :white, :brown, :green, :purple, :orange, :pink], [], [], [], judge_server, 0, 0) end)
  end

  def left_num(colors, left_server, right_server, judge_server, left_score, right_score) do
    [a, b, c, d, e, f, g, h, i, j] = colors
    color = receive do
      {:user, sender} -> send(sender, {:left, self()})
      %{user: user, left: server_l, right: server_r, judge: server_j} -> send(user, {:server_l, :here})
    end
  end

  def right_num(colors, left_server, right_server, judge_server, left_score, right_score) do
    [a, b, c, d, e, f, g, h, i, j] = colors
    color = receive do
      {:user, sender} -> send(sender, {:right, self()})
      %{user: user, left: server_l, right: server_r, judge: server_j} -> send(user, {:server_r, :here})
    end
  end

  def judge_num(colors, user_server, left_server, right_server, judge_server, left_score, right_score) do
    [a, b, c, d, e, f, g, h, i, j] = colors
    color = receive do
      {:user, sender} -> send(sender, [{:judge, self()}, "left score is #{left_score} and right score is #{right_score}"])
      %{user: user, left: server_l, right: server_r, judge: server_j} ->
        #judge_num(colors, user, server_l, server_r, server_j, left_score, right_score)
        servers = %{user: user_server = user, left: server_l, right: server_r, judge: server_j}
        send(user, {:return, :sent})
        send(server_l, servers)
        send(server_r, servers)
      #{:server_r, :here} -> send(user_server, {:server_r, :here})
      #{:server_l, :here} -> send(user_server, {:server_l, :here})
    end
  end
end
