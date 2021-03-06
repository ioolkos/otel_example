%%%-------------------------------------------------------------------
%% @doc otel_example public API
%% @end
%%%-------------------------------------------------------------------

-module(otel_example_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    application:load(opentelemetry),

    ok = application:set_env(opentelemetry, sampler, {always_on, #{}}),
    ok = application:set_env(opentelemetry, processors, [{otel_batch_processor, #{exporter => {otel_exporter_stdout, []},
                                                                            exporting_timeout_ms => 5000,
                                                                            scheduled_delay_ms => timer:seconds(5)}}]),

    {ok, _} = application:ensure_all_started(opentelemetry_api),
    {ok, _} = application:ensure_all_started(opentelemetry),

    ok = otel_batch_processor:set_exporter(otel_exporter_stdout, []),
    true = opentelemetry:register_application_tracer(otel_example), 
    

    % otel_batch_processor:set_exporter(opentelemetry_exporter, #{protocol => http_protobuf,
    %                                                          endpoints => [
    %                                                          {http, "localhost", 9090, []}],
    %                                                          scheduled_delay_ms => 10000}),
    otel_example_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
