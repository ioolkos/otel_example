-module(instrumented_module).

-include_lib("opentelemetry_api/include/otel_tracer.hrl").

-export([span_with_delay_ms/1, span_with_sleep_ms/1]).


span_with_delay_ms(Delay) ->
Sampler = otel_sampler:setup(always_on, #{}),
Tracer = opentelemetry:get_tracer(otel_example),
io:format("Sampler: ~p~n,  Tracer: ~p~n", [Sampler, Tracer]),
otel_tracer:with_span(Tracer, <<"span_with_delay/1">>, #{sampler => Sampler, is_recording => true}, 
  fun(_SpanCtx) ->
    SpanCtx = otel_tracer:current_span_ctx(),

    otel_span:set_attribute(SpanCtx, <<"Delay">>, Delay),
    timer:sleep(Delay)
    end).


span_with_sleep_ms(Delay) ->
Sampler = otel_sampler:setup(always_on, #{}),
Tracer = opentelemetry:get_tracer(otel_example),
io:format("Sampler: ~p~n,  Tracer: ~p~n", [Sampler, Tracer]),
otel_tracer:with_span(Tracer, <<"span_with_sleep_ms/1">>, #{sampler => Sampler, is_recording => true}, 
  fun(SpanCtx) ->
    otel_span:set_attribute(SpanCtx, <<"Delay">>, Delay),
    timer:sleep(Delay)
    end).