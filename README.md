otel_example
=====

An OTP application

Build
-----

    $ rebar3 compile
    $ erl -pa _build/default/lib/*/ebin -pa _build/default/lib/*/apps/*/ebin
    Eshell V11.1.4  (abort with ^G)
    1> application:start(otel_example).
    ok
    2> instrumented_module:span_with_sleep_ms_2(1000).
    *SPANS FOR DEBUG*
    ok
    3> *SPANS FOR DEBUG*
    {span,87313737888284145423376002069858722709,16567822515868545333,undefined,
      undefined,<<"instrumented_module:span_with_sleep2">>,'INTERNAL',
      -576460732348564606,-576460731344815009,
      [{<<"delay">>,1000}],
      [],[],undefined,1,false,
      {instrumentation_library,<<"otel_example">>,<<"0.1.0">>}}


