require 'yaml'

# This script generates initial YAML file
# and is inteded to be used only once :)

pubs = [

{ :head => { :author => "Ilya Dmitrichenko", :title => "Publications of" } },

{
 :cite => "dummy00xxx",
 :year => 2011,
 :name => "An example",
 :desc => "",
 :view => "http://docs.example.com/dummy.htm",
 :file => "http://docs.example.com/dummy.pdf"
},
{
 :cite => "dmit11wmi",
 :year => 2011,
 :name => "WMI - Wireless Music Instrumens",
 :desc => "BSc project final report",
 :view => "https://docs.google.com/viewer?a=v&pid=explorer&srcid=1YGD6Do86b7hETdlexIIh9O7gUVIWtRXdPFaKbBqJy4M_OQLROAzIXYr4r9df&hl=en_US",
 :file => "https://doc-0o-2g-docsviewer.googleusercontent.com/viewer/securedownload/i1mg3tlfajfnt8caeae2fd0i9h5ls8bq/fri7gsav1lpr4hmtattug7e07gqq2d2d/1310476500000/ZXhwbG9yZXI=/AGZ5hq8_jP8S94LFThFw6gjDooCS/MVlHRDZEbzg2YjdoRVRkbGV4SUloOU83Z1VWSVd0UlhkUEZhS2JCcUp5NE1fT1FMUk9BeklYWXI0cjlkZg==?a=dl&filename=final_report_links.pdf&sec=AHSqidZd3iIsnkLtJqOiygQkhlsnrQHhFWUdMUQWUqqkIzoRMl2qfndQi8AEUcWFWeWKcOUmySM0T-QI8s5NvszMFsUIWkUFaHkHiQ5R3p0Vx5bRcJLfQ8iDSVNMy2RSDFu4ggHfpCr6371-lrVeS8pTxXNJbqfRg_5zyyWNghS7M-kfOhwk4PaJM3FWV4wD_4SzP_LC0YNp_6a3Mg01YOofIeV9f4k_lxQzzhOEcjLKMlIhGLkm5iczFysJT-jlZH__7CRkNEp8UtOONYCtXSAwJeNwLxMpMSoCoByRSKhFqalg614Cep6YB2oAk1YLe5RBO55-OSnZSe1itTkT01qNGLqDRdk2w2Rgcxz43T1vLh_rNLqkMwLmao5BclW1F6VpalZzAQ7dfuSPKQjLW221f-mnjHI2TF1RhyGTgSpCAX-FOO3re5CudUnOAseCx7UMbKg_bUXr&nonce=ihsvf1nbevcei&user=AGZ5hq8_jP8S94LFThFw6gjDooCS&hash=vjccgac3hp7qae3kve5bie5os0oujb20"
}
]

File.open('gdocs_pubs.yml', 'w') {|f| f.write(pubs.to_yaml) }
