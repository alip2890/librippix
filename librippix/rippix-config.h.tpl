[+ AutoGen5 template h +]
/* Copyright (C) 2012
   Aljosha Papsch <papsch.al@googlemail.com>

   Configuration API for Rippix. The backend must be provided by the frontend.

   This file is part of librippix.

   librippix is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   librippix is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with librippix.  If not, see <http://www.gnu.org/licenses/>. */

#ifndef RW_CONFIG_H
#define RW_CONFIG_H

/* Enumeration of all available configuration keys. These are used to address
   a configuration option in a convenient way. Pass this to the config_read and
   config_write functions. */
typedef enum {
  [+ FOR configlist "," +]
  CONFIG_[+ (string-upcase! (get "configlist_key")) +] [+
  ENDFOR configlist +]
} RippixConfigKey;

/* Determines which type a configuration value has. This may be important for some
   configuration systems such as dconf. Also, all configuration keys are associated
   with a ConfValueType, so no doubts should emerge to what data type a value
   returned from config_read should be casted. */
typedef enum {
  CONF_VALUE_STRING,
  CONF_VALUE_INT,
  CONF_VALUE_FLOAT,
  CONF_VALUE_BOOL
} ConfValueType;

/* Read a value from the configuration tied to key specified by key.
   Possible values for key: see above
   Returns: The value of the key, cast it specifally.
 */
void*
config_read (RippixConfigKey key);

/* Writes a value to the configuration tied to key specified by key.
   data_value must be a pointer which can be casted correctly according
   to data_type. */
int
config_write (RippixConfigKey key,
	      const void *data_value);

/* Returns the configuration key string for the specified key. The configuration
   backend should use this to identify the configuration option. */
const char*
get_conf_key_string (RippixConfigKey key);

/* Returns the ConfValueType for the key specified by key. */
const ConfValueType
get_conf_key_type (RippixConfigKey key);

/* Registers the callback function in the frontend which reads a configuration
   value. First argument is the configuration key string. config_read passes
   the right key string by calling get_conf_key_string, so only worry about getting
   the value for that given string. */
void
register_cfgread_cb (void* (*cb)(const char*));

/* Registers the callback function in the frontend which writes a configuration
   value. First argument is the configuration key string (see above). Second
   argument is the type of the third argument, which holds the actual data
   to write. config_write passes all the right arguments. */
void
register_cfgwrite_cb (int (*cb)(const char*, const ConfValueType, const void*));

#endif // RW_CONFIG_H
