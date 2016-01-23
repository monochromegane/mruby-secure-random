/*
** mrb_securerandom.c - SecureRandom class
**
** Copyright (c) monochromegane 2016
**
** See Copyright Notice in LICENSE
*/

#include "mruby.h"
#include "mruby/data.h"
#include "mrb_securerandom.h"

#define DONE mrb_gc_arena_restore(mrb, 0);

typedef struct {
  char *str;
  int len;
} mrb_securerandom_data;

static const struct mrb_data_type mrb_securerandom_data_type = {
  "mrb_securerandom_data", mrb_free,
};

static mrb_value mrb_securerandom_init(mrb_state *mrb, mrb_value self)
{
  mrb_securerandom_data *data;
  char *str;
  int len;

  data = (mrb_securerandom_data *)DATA_PTR(self);
  if (data) {
    mrb_free(mrb, data);
  }
  DATA_TYPE(self) = &mrb_securerandom_data_type;
  DATA_PTR(self) = NULL;

  mrb_get_args(mrb, "s", &str, &len);
  data = (mrb_securerandom_data *)mrb_malloc(mrb, sizeof(mrb_securerandom_data));
  data->str = str;
  data->len = len;
  DATA_PTR(self) = data;

  return self;
}

static mrb_value mrb_securerandom_hello(mrb_state *mrb, mrb_value self)
{
  mrb_securerandom_data *data = DATA_PTR(self);

  return mrb_str_new(mrb, data->str, data->len);
}

static mrb_value mrb_securerandom_hi(mrb_state *mrb, mrb_value self)
{
  return mrb_str_new_cstr(mrb, "hi!!");
}

void mrb_mruby_securerandom_gem_init(mrb_state *mrb)
{
    struct RClass *securerandom;
    securerandom = mrb_define_class(mrb, "SecureRandom", mrb->object_class);
    mrb_define_method(mrb, securerandom, "initialize", mrb_securerandom_init, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, securerandom, "hello", mrb_securerandom_hello, MRB_ARGS_NONE());
    mrb_define_class_method(mrb, securerandom, "hi", mrb_securerandom_hi, MRB_ARGS_NONE());
    DONE;
}

void mrb_mruby_securerandom_gem_final(mrb_state *mrb)
{
}

