defmodule GreedyTest do
  use ExUnit.Case
  doctest Greedy

  test "gets a bunch of records" do
    assert Greedy.latest() == [
             %{
               "created_at" => 1_552_506_968_136.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 19:56:08.252757",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_507_033_385.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 19:57:13.529893",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_507_757_015.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 20:09:17.202139",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_509_439_916.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 20:37:20.008348",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_509_518_560.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 20:38:39.199132",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_509_588_033.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 20:39:48.482755",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_510_080_299.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 20:48:00.503241",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_510_155_079.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 20:49:15.740443",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_510_214_504.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 20:50:15.146699",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_512_809_399.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:33:29.856716",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_512_895_867.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:34:56.122106",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_512_967_856.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:36:07.955676",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_513_048_167.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:37:28.660284",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_513_261_316.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:41:01.431776",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_513_421_098.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:43:41.215296",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_513_460_522.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:44:20.646559",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_513_499_507.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:44:59.581663",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_514_301_541.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:58:21.713172",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_514_328_338.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:58:48.467437",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_514_361_930.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:59:22.174232",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_514_393_436.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 21:59:53.586159",
               "source" => "fedora",
               "verb" => "user_created"
             },
             %{
               "created_at" => 1_552_516_825_147.0,
               "metadata" => %{
                 "metadata" => %{"test" => "value"},
                 "source" => "fedora"
               },
               "noun" => "user",
               "noun_id" => "45",
               "received_at" => "2019-03-13 22:40:25.319938",
               "source" => "fedora",
               "verb" => "user_created"
             }
           ]
  end
end
