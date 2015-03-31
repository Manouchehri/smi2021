# smi2021

Get base from https://github.com/jonjonarnearne/smi2021 (only /usr/src/linux/drivers/media/usb/smi2021)

Add some path from https://github.com/kerpz/smi2021 and https://github.com/barneyman/somagic - for compile
And add some performance improve to parse_video

From:

```
CPU: Core 2, speed 2.394e+06 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Clock cycles when not halted) with a unit mask of 0x00 (Unhalted core cycles) count 100000
```
|samples | %       |    symbol name               |                   |samples | %        |              symbol name|
|--------|---------|------------------------------|-------------------|--------|----------|-------------------------|
|57171   | 98.5741 | smi2021_iso_cb               | smi2021.ko        |3       |   100.000| smi2021_iso_cb          |
|57171   | 99.6010 | smi2021_iso_cb [self]        | smi2021.ko        |2714    |   82.2923| smi2021_iso_cb          |
|161     |  0.2805 | smi2021_free_isoc            | smi2021.ko        |2714    |   82.1926| smi2021_iso_cb [self]   |
|68      |  0.1185 | copy_video                   | smi2021.ko        |584     |   17.6863| copy_video_block        |
|        |         |                              | smi2021.ko        |3       |    0.0909| smi2021_iso_cb          |
|        |         |                              | smi2021.ko        |1       |    0.0303| smi2021_buf_done        |
|--------|---------|------------------------------|-------------------|--------|----------|-------------------------|
|161     | 35.3846 | smi2021_iso_cb               | smi2021.ko        |584     |   100.000| smi2021_iso_cb          |
|294     | 64.6154 | smi2021_start                | smi2021.ko        |584     |   17.7077| copy_video_block        |
|455     |  0.7845 | smi2021_free_isoc            | smi2021.ko        |584     |   100.000| copy_video_block [self] |
|455     | 100.000 | smi2021_free_isoc [self]     |                   |        |          |                         |
|--------|---------|------------------------------|-------------------|--------|----------|-------------------------|
|68      | 38.6364 | smi2021_iso_cb               | smi2021.ko        |0       |         0| buffer_queue            |
|108     | 61.3636 | smi2021_start                | videobuf2-core.ko |1       |   100.000| vb2_plane_vaddr         |
|176     |  0.3035 | copy_video                   | smi2021.ko        |0       |         0| buffer_queue [self]     |
|176     | 100.000 | copy_video [self]            |                   |        |          |                         |
|--------|---------|------------------------------|-------------------|--------|----------|-------------------------|
|118     |  0.2035 | smi2021_start                | smi2021.ko        |1       |   100.000| smi2021_iso_cb          |
|294     | 56.5385 | smi2021_free_isoc            | smi2021.ko        |0       |         0| smi2021_buf_done        |
|118     | 22.6923 | smi2021_start [self]         | videobuf2-core.ko |1       |   100.000| vb2_buffer_done         |
|108     | 20.7692 | copy_video                   | smi2021.ko        |0       |         0| smi2021_buf_done [self] |
|--------|---------|------------------------------|-------------------|--------|----------|-------------------------|
|4       | 100.000 | smi2021_usb_disconnect       | smi2021.ko        |1       |   100.000| smi2021_buf_done        |
|58      |  0.1000 | smi2021_usb_disconnect       | videobuf2-core.ko |0       |         0| vb2_buffer_done         |
|58      | 93.5484 | smi2021_usb_disconnect [self]| videobuf2-core.ko |0       |         0| vb2_buffer_done [self]  |
|4       |  6.4516 | smi2021_usb_disconnect       |                   |        |          |                         |
|--------|---------|------------------------------|-------------------|--------|----------|-------------------------|
|20      |  0.0345 | smi2021_toggle_audio         | smi2021.ko        |1       |   100.000| buffer_queue            |
|20      | 100.000 | smi2021_toggle_audio [self]  | videobuf2-core.ko |0       |         0| vb2_plane_vaddr         |
|        |         |                              | videobuf2-core.ko |0       |         0| vb2_plane_vaddr [self]  |


