Spree::Admin::OverviewController.class_eval do

  def get_mailing_list_csv
    @mailing_list = MailingList.order(:created_at)
    respond_to do |format|
      format.html
      format.csv {
        generate_csv_headers("negotiations-#{Time.now.strftime("%Y%m%d")}")
        send_data @mailing_list.to_csv
      }
    end
  end

  private

  def generate_csv_headers(filename)
    headers.merge!({
                       'Cache-Control' => 'must-revalidate, post-check=0, pre-check=0',
                       'Content-Type' => 'text/csv',
                       'Content-Disposition' => "attachment; filename=\"#{filename}\"",
                       'Content-Transfer-Encoding' => 'binary'
                   })
  end
end
