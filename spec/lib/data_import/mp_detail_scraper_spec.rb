require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require File.join(Rails.root, "/lib/data_import/mp_data_importer")

describe MPDetailScraper do
  
  context "import" do
    it "returns all details of an MP" do
      mp_detail = MPDetailScraper.new.import "Biography.aspx?mpsno=4024"
      mp_detail[:fathers_name].should == "Shri S. Konda Reddy"
      mp_detail[:mothers_name].should == "Smt. S. Veeramma"
      mp_detail[:date_of_birth].should == "04 Jun 1950"
      mp_detail[:place_of_birth].should == "Ankalamma Cudur, Distt. Cuddapah (Andhra Pradesh)"
      mp_detail[:martial_status].should == "Married"
      mp_detail[:date_of_marriage].should == "20 Nov 1975"
      mp_detail[:spouse_name].should == "Smt. S. Parvathi"
      mp_detail[:no_of_sons].should be_blank
      mp_detail[:no_of_daughters].should == "2"
      mp_detail[:educational_qualifications].should == "B.E. (Mechanical) Educated at Reginal Engg. College, Warangal (Andhra Pradesh)"
      mp_detail[:profession].should == "Industrialist Agriculturist Engineer Social Worker"
      mp_detail[:permanent_address].should == "30/726, Bommala Satram, Nandyal,Kurnool Distt.Andhra Pradesh - 518 502 Tels. (08514) 243305, 9848020190, 9440251558 (M) Fax (08514) 243350"
      mp_detail[:present_address].should == "No.1, Ferozeshah Road, New Delhi - 110 001 Tels. (011) 23352526, 23315811, 9868180182 (M)Fax. (011) 23315811"
      
      mp_detail[:photo].should == "http://164.100.47.132/mpimage/photo/4024.jpg"
      mp_detail[:email].should == " spy.reddy@sansad.nic.in "
      
      mp_detail[:positions].should == [
        {:period=>"2000-2003", :name=>"Chairman, Muncipal  Corporation of Nandyal"},
        {:period=>"2004", :name=>"Elected to 14th Lok Sabha"},
        {:period=>"", :name=>"Member, Committee on Commerce"},
        {:period=>"", :name=> "Member, Joint  Committee on Salaries and Allowances of  Members of Parliament"},
        {:period=>"2009", :name=>"Re-elected to 15th Lok Sabha (2nd term)"},
        {:period=>"31 Aug. 2009", :name=>"Member, Committee on Water Resources, Lok Sabha"},
        {:period=>"23 Sept. 2009", :name=>"Member, Rules Committee"}
      ]
      
      mp_detail[:activity].should == {
        :sports_and_clubs=>"Member, Constitution Club", 
        :countries_visited=>"Germany,  Singapore and U.A.E. (Dubai)", 
        :other_information=>"Scientific Officer, B.A.R.C. , Mumbai, 1974-77", 
        :special_interests=>"Public service"
      }
      
    end
  end
  
end