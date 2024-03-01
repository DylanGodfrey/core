def deep_update(base_dict, update_with):
    # iterate over each item in dict
    for key, value in update_with.items():
        # If a dict is nested inside
        if isinstance(value, dict):
            base_dict_value = base_dict.get(key)
            # If original value is also a dict, repeat recursively
            if isinstance(base_dict_value, dict):
                deep_update(base_dict_value, value)
            # If original value is NOT a dict, just set new value
            else:
                base_dict[key] = value
        # If new value is NOT a dict
        else:
            base_dict[key] = value

    return base_dict
