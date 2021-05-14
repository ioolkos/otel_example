-module(instrumented_module).

-include_lib("opentelemetry_api/include/otel_tracer.hrl").
%-include_lib("opentelemetry_api/include/opentelemetry.hrl").


-export([span_with_sleep_ms/1, span_with_sleep_ms_2/1]).

% Approach 1: with Tracer and Sampler
span_with_sleep_ms(Delay) ->
Sampler = otel_sampler:setup(always_on, #{}),
Tracer = opentelemetry:get_tracer(otel_example),
%io:format("Sampler: ~p~n,  Tracer: ~p~n", [Sampler, Tracer]),
otel_tracer:with_span(Tracer, <<"span_with_sleep_ms/1">>, #{sampler => Sampler, is_recording => true}, 
  fun(SpanCtx) ->
    otel_span:set_attribute(SpanCtx, <<"Delay">>, Delay),
    timer:sleep(Delay)
    end).
% Approach 2: with ?with_span macro
span_with_sleep_ms_2(Delay) ->
  ?with_span(<<"instrumented_module:span_with_sleep2">>, #{}, 
  fun(_SpanCtx) ->
  ?set_attribute(<<"delay">>, Delay),
        timer:sleep(Delay)
        end).