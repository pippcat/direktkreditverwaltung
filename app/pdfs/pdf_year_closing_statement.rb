class PdfYearClosingStatement < Prawn::Document
  include PdfHelper


  def initialize(statement)
    @statement = statement
    @contract = statement.contract
    @year = statement.year
    super(page_size: 'A4', top_margin: 30, left_margin: 55)

    font 'Helvetica'

    gmbh_adress = "#{association.association_name}     #{association.street}     #{association.zip_code} #{association.city}"
    gmbh_mail = association.email
    gmbh_greet = "Die Finanz-Crew der #{association.association_name}"
    kunet_adress = "#{association.verein_name}     #{association.street}     #{association.zip_code} #{association.city}"
    kunet_mail = "post@kuneterakete.de"
    kunet_greet = "Die Finanz-Crew des #{association.verein_name}"

    is_kunet_contract = @contract.number.index("70") == 0 ? true : false;
    association_adress = is_kunet_contract ? kunet_adress : gmbh_adress;
    association_mail = is_kunet_contract ? kunet_mail : gmbh_mail;
    farewell_formula = is_kunet_contract ? kunet_greet : gmbh_greet

    postal_address_and_header(association_adress, association_mail)

    move_down 40

    text "#{association.city}, den #{DateTime.now.strftime("%d.%m.%Y")}", align: :right
    move_down 40
    text "Kontostand Nachrangdarlehen Nr. #{@contract.number}", size: 12, style: :bold
    move_down 30
    text "Hallo #{@contract.try(:contact).try(:prename)} #{@contract.try(:contact).try(:name)},"
    move_down 10
    text "herzlichen Dank für die Unterstützung im Jahr #{@year}. Anbei der Kontoauszug und die Berechnung der Zinsen. " +
             "Auf Wunsch erstellen wir eine gesonderte Zinsbescheinigung für die Steuererklärung."
    move_down 5
    text " Wir bitten um Überprüfung des Auszugs. " +
         "Falls etwas nicht stimmt oder unverständlich ist, stehen wir für Rückfragen gern zur Verfügung."
    move_down 5
    text "Die Zinsen wurden auf dem Direktkreditkonto gutgeschrieben. Auf Wunsch zahlen wir diese auch gern aus." if @contract.add_interest_to_deposit_annually
    move_down 10
    text "Buchungsübersicht", style: :bold
    move_down 5

    interest_calculation_table

    move_down 10
    text "Kontostand zum Jahresabschluss #{ @year }: <b>#{ currency(@contract.balance(Date.new(@year, 12, 31))) }</b>", inline_format: true
    move_down 15
    text "Wir werden die Zinsen in den nächsten Tagen auf das im Vertrag angegebene Konto überweisen." unless @contract.add_interest_to_deposit_annually
    text "Zinseinkünfte sind einkommensteuerpflichtig.", style: :bold, align: :center
    move_down 10
    text "Vielen Dank!"
    move_down 30
    text "Mit freundlichen Grüßen"
    text farewell_formula
    move_down 30

    is_kunet_contract ? nil : footer
  end

  def postal_address_and_header association_adress, association_mail
    image_width = 180
    image_heigth = 52
    address_y_pos = 110

    x_pos = bounds.width-image_width
    y_pos = cursor

    image_file = "#{Rails.root}/custom/logo.png"
    image(image_file, at: [x_pos, y_pos], width: image_width) if File.exists?(image_file)

    bounding_box [x_pos + 55, y_pos - image_heigth],
                 width: image_width do
      text association.name, size: 10
      text "Projekt im Mietshäuser Syndikat", size: 8, style: :italic
      move_down 10
      if association.building_street && association.building_zipcode
        text association.building_street, size: 8
        text "#{association.building_zipcode} #{association.city}", size: 8
      else
        text association.street, size: 8
        text "#{association.zip_code} #{association.city}", size: 8
      end

      move_down 10
      text association_mail, size: 8 # kunet vs. gmbh
      text association.web, size: 8
    end

    bounding_box [0, y_pos - address_y_pos],
                 width: image_width do
      fill_color '777777'
      text association_adress, size: 7 # kunet vs. gmbh
      fill_color '000000'
      move_down 10
      text "#{@contract.contact.try(:prename)} #{@contract.contact.try(:name)}"
      address = @contract.contact.try(:address)
      if address
        address_array = address.split(',')
        (0..(address_array.length-2)).to_a.each do |i|
          text address_array[i]
        end
        text address_array.last
      end
    end
  end


  #TODO: Statement could use a method which return the following array of arrays for table rendering (Presenter)
  def interest_calculation_table
    data = [['Datum', 'Vorgang', 'Betrag', 'Zinssatz']]
    @statement.movements.each do |movement|
      unless movement[:type] == :movement && movement[:amount] < 0.0
        data << [
            movement[:date].strftime('%d.%m.%Y'),
            name_for_movement(movement),
            currency(movement[:amount].to_s),
            fraction(movement[:interest_rate])
        ]
      else
        data << [
            movement[:date].strftime('%d.%m.%Y'),
            name_for_movement(movement),
            currency(movement[:amount].to_s)
        ]
      end
    end

    # additional row for account balance at closing date
    closing_date = Date.new(@year, 12, 31)
    data << [closing_date.strftime('%d.%m.%Y'), "Saldo", "#{currency(@contract.balance(closing_date))}"]

    table data do
      row(0).font_style = :bold
      columns(2..6).align = :right
      self.row_colors = ["EEEEEE", "FFFFFF"]
      self.cell_style = {size: 8}
      self.header = true
    end
  end

  def footer
    #footer
    y_pos = 25
    self.line_width = 0.5
    stroke_line [0, y_pos], [bounds.width, y_pos]
    fill_color '777777'
    y_pos -= 5
    bounding_box [20, y_pos], width: bounds.width/3.0 do
      text association.bank_name, size: 8
      text association.iban, size: 8
    end
    bounding_box [20 + bounds.width/3.0, y_pos], width: bounds.width/3.0 do
      text "Geschäftsführung", size: 8
      text association.association_board, size: 8
    end
    bounding_box [20 + 2*bounds.width/3.0, y_pos], width: bounds.width/3.0 do
      text "Registergericht: #{association.county_court}", size: 8
      text "Steuernummer: #{association.association_register}", size: 8
    end
  end

  private
  def texts
    hash = YAML.load_file("#{Rails.root}/custom/text_snippets.yml")
    HashWithIndifferentAccess.new(hash)
  end

end
