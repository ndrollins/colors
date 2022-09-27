defmodule Colors do
  def left do
    spawn( fn ->
      left_server = self() 
      left_color([:red, :yellow, :blue, :black, :white, :brown, :green, :purple, :orange, :pink, :grey], left_server, []) end)
  end

  def right do
    spawn( fn ->
      right_server = self() 
      right_color([:red, :yellow, :blue, :black, :white, :brown, :green, :purple, :orange, :pink, :grey], right_server, []) end)
  end

  def judge do
    spawn(fn -> 
      judge_server = self() 
      judge_color([:red, :yellow, :blue, :black, :white, :brown, :green, :purple, :orange, :pink, :grey], judge_server, []) end)
  end

  def left_num(colors, user_server, left_server, right_server, judge_server, left_score, right_score, left_colors, right_colors, judge_colors) do
    color = receive do
      %{user: user, left: server_l, right: server_r, judge: server_j} -> send(user, {:server_l, :here})
        send(server_j, {:left, self(), hd(left_colors)})
        left_num(colors, user, server_l, server_r, server_j, left_score, right_score, left_colors, right_colors, judge_colors)
      {:guess_again, server_j} -> 
        [a, b, c, d, e, f, g, h, i, j, k] = colors
        color_l = 
          case round(10 * :rand.uniform) do
            0 -> color_l = a
            1 -> color_l = b
            2 -> color_l = c
            3 -> color_l = d
            4 -> color_l = e
            5 -> color_l = f
            6 -> color_l = g
            7 -> color_l = h
            8 -> color_l = i
            9 -> color_l = j
            10 -> color_l = k
          end
        send(server_j, {:left, self(), color_l})
        left_color(colors, self(), left_colors)
    end
  end

  def right_num(colors, user_server, left_server, right_server, judge_server, left_score, right_score, left_colors, right_colors, judge_colors) do
    color = receive do
      %{user: user, left: server_l, right: server_r, judge: server_j} -> send(user, {:server_r, :here})
        send(server_j, {:right, self(), hd(right_colors)})
        right_num(colors, user, server_l, server_r, server_j, left_score, right_score, left_colors, right_colors, judge_colors)
      {:guess_again, server_j} -> 
        [a, b, c, d, e, f, g, h, i, j, k] = colors
        color_r = 
          case round(10 * :rand.uniform) do
            0 -> color_r = a
            1 -> color_r = b
            2 -> color_r = c
            3 -> color_r = d
            4 -> color_r = e
            5 -> color_r = f
            6 -> color_r = g
            7 -> color_r = h
            8 -> color_r = i
            9 -> color_r = j
            10 -> color_r = k
          end
        send(server_j, {:right, self(), color_r})
        right_color(colors, self(), right_colors)
    end
  end

  defp left_color(colors, left_server, left_colors) do
    [a, b, c, d, e, f, g, h, i, j, k] = colors
    color_l = 
      case round(10 * :rand.uniform) do
        0 -> color_l = a
        1 -> color_l = b
        2 -> color_l = c
        3 -> color_l = d
        4 -> color_l = e
        5 -> color_l = f
        6 -> color_l = g
        7 -> color_l = h
        8 -> color_l = i
        9 -> color_l = j
        10 -> color_l = k
      end
    left_num(colors, [], left_server, [], [], 0, 0, [color_l | left_colors], [], [])
  end

  defp right_color(colors, right_server, right_colors) do
    [a, b, c, d, e, f, g, h, i, j, k] = colors
    color_r = 
      case round(10 * :rand.uniform) do
        0 -> color_r = a
        1 -> color_r = b
        2 -> color_r = c
        3 -> color_r = d
        4 -> color_r = e
        5 -> color_r = f
        6 -> color_r = g
        7 -> color_r = h
        8 -> color_r = i
        9 -> color_r = j
        10 -> color_r = k
      end

    right_num(colors, [], [], right_server, [], 0, 0, [], [color_r | right_colors], [])
  end

  defp judge_color(colors, judge_server, judge_colors) do
    [a, b, c, d, e, f, g, h, i, j, k] = colors
    color_j = 
      case round(10 * :rand.uniform) do
        0 -> color_j = a
        1 -> color_j = b
        2 -> color_j = c
        3 -> color_j = d
        4 -> color_j = e
        5 -> color_j = f
        6 -> color_j = g
        7 -> color_j = h
        8 -> color_j = i
        9 -> color_j = j
        10 -> color_j = k
      end
    judge_num([:red, :yellow, :blue, :black, :white, :brown, :green, :purple, :orange, :pink, :grey], [], [], [], judge_server, 0, 0, [], [], [color_j | judge_colors])
  end

  def judge_num(colors, user_server, left_server, right_server, judge_server, left_score, right_score, left_colors, right_colors, judge_colors) do
    color = receive do
      {:user, sender} -> 
        send(sender, [{:judge, self()}, "left score is #{left_score} and right score is #{right_score}", {:left, left_colors}, {:right, right_colors}, {:judge, judge_colors}])
        judge_num(colors, user_server, left_server, right_server, judge_server, left_score, right_score, left_colors, right_colors, judge_colors)

      {:guess_again, server_j} -> 
        [a, b, c, d, e, f, g, h, i, j, k] = colors
        color_j = 
          case round(10 * :rand.uniform) do
            0 -> color_j = a
            1 -> color_j = b
            2 -> color_j = c
            3 -> color_j = d
            4 -> color_j = e
            5 -> color_j = f
            6 -> color_j = g
            7 -> color_j = h
            8 -> color_j = i
            9 -> color_j = j
            10 -> color_j = k
          end
        send(server_j, {:right, self(), color_j})
        judge_num(colors, user_server, left_server, right_server, judge_server, left_score, right_score, left_colors, right_colors, [color_j | judge_colors])

      {:right, server_r, color_r} -> 
        if color_r == hd(judge_colors) do
          if right_score + 1 == 2 do
            send(user_server, [{:judge, self()}, "left score is #{left_score} and right score is #{right_score + 1}", {:left, left_colors}, {:right, right_colors}, {:judge, judge_colors}])
          else
            send(self(), {:guess_again, self()})
            judge_num(colors, user_server, left_server, right_server, judge_server, left_score, right_score + 1, left_colors, [color_r | right_colors], judge_colors)

          end
        else
          send(server_r, {:guess_again, self()})
          judge_num(colors, user_server, left_server, right_server, judge_server, left_score, right_score, left_colors, [color_r | right_colors], judge_colors)
        end

      {:left, server_l, color_l} -> 
        if color_l == hd(judge_colors) do
          if left_score + 1 == 2 do
            send(user_server, [{:judge, self()}, "left score is #{left_score + 1} and right score is #{right_score}", {:left, left_colors}, {:right, right_colors}, {:judge, judge_colors}])
          else
            send(self(), {:guess_again, self()})
            judge_num(colors, user_server, left_server, right_server, judge_server, left_score + 1, right_score, [color_l | left_colors], right_colors, judge_colors)
          end
        else
          send(server_l, {:guess_again, self()})
          judge_num(colors, user_server, left_server, right_server, judge_server, left_score, right_score, [color_l | left_colors], right_colors, judge_colors)
        end

      %{user: user, left: server_l, right: server_r, judge: server_j} ->
        servers = %{user: user_server = user, left: server_l, right: server_r, judge: server_j}
        send(user, {:return, :sent})
        send(server_l, servers)
        send(server_r, servers)
        judge_num(colors, user, server_l, server_r, server_j, left_score, right_score, left_colors, right_colors, judge_colors)
    end
  end
end
