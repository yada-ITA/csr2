# coding: utf-8

require 'test_helper'

class ScenarioTest < AcceptanceTest
  fixtures :users, :companies, :enginestatuses, :businessstatuses

  # シナリオ１(sprint#2)
  test "scenario-1 of sprint-2" do
    ###########################################################################
    # 1. 管轄外のエンジン２が SG に送られてきた [@SG]
    #    -> エンジンを新規登録して、そのエンジンを受領する
    ###########################################################################

    # 1.1. サインインする
    sign_in "SG000001", "password"
    save_screenshot "scenario1-1_1.png"
    # 1.2. エンジン一覧画面を開く
    click_link "エンジン一覧"
    save_screenshot "scenario1-1_2.png"
    # 1.3. エンジン新規登録画面を開く
    click_link "新規登録"
    save_screenshot "scenario1-1_3.png"
    # 1.4. エンジンを登録する
    fill_in "エンジン型式", with: "ENG0002"
    fill_in "エンジンS/#", with: "SN0001"
    save_screenshot "scenario1-1_4_1.png"
    click_button "登録する"
    save_screenshot "scenario1-1_4_2.png"
    # 1.5. エンジン一覧画面に戻る
    click_link "Back"
    assert has_content? "ENG0002"
    save_screenshot "scenario1-1_5.png"
    # 1.6. 受領画面を開く
    click_link "受領登録"
    # 返却コメントは入力できなくなった？
    #comment = "そろそろメンテナンスをお願いします。"
    #fill_in "返却コメント", with: comment
    save_screenshot "scenario1-1_6_1.png"
    click_button "受領登録"
    save_screenshot "scenario1-1_6_2.png"
    # 1.7. 整備作業一覧画面に移動する
    click_link "Back"
    within "tbody > tr" do
      #assert_equal comment, nth_tag(:td, 8).text    # 返却コメント
      assert_equal "ENG0002", nth_tag(:td, 9).text # エンジン型式
      assert_equal "SN0001", nth_tag(:td, 10).text  # エンジンS/#
      assert_equal "整備前", nth_tag(:td, 11).text  # ステータス
    end
    save_screenshot "scenario1-1_7.png"
    # 1.8. サインアウトする
    sign_out
    save_screenshot "scenario1-1_8.png"

    ###########################################################################
    # 2. エンジン２の整備依頼を行う [@AA]
    ###########################################################################

    # 2.1. サインインする
    sign_in "AA000001", "password"
    save_screenshot "scenario1-2_1.png"
    # 2.2. 整備作業一覧画面を開く
    click_link "整備一覧"
    save_screenshot "scenario1-2_2.png"
    # 2.3. 整備依頼画面を開く
    click_link "整備依頼"
    fill_in "注文No", with: "123456"
    fill_in "工事No(仮)", with: "654321"
    select "2014", from: "repair[desirable_finish_date(1i)]" # 希望完成日(年)
    select "1",   from: "repair[desirable_finish_date(2i)]"  # 希望完成日(月)
    select "15",   from: "repair[desirable_finish_date(3i)]" # 希望完成日(日)
    save_screenshot "scenario1-2_3_1.png"
    click_button "整備依頼"
    save_screenshot "scenario1-2_3_2.png"
    # 2.4. 整備作業一覧画面に移動する
    click_link "Back"
    within "tbody > tr" do
      assert_equal "2014-01-15", nth_tag(:td, 5).text # 完成希望日
      assert_equal "整備前", nth_tag(:td, 11).text    # ステータス
    end
    save_screenshot "scenario1-2_4.png"
    # 2.5. サインアウトする
    sign_out
    save_screenshot "scenario1-2_5.png"

    ###########################################################################
    # 3. エンジン２の整備を開始した [@SG]
    ###########################################################################

    # 3.1. サインインする
    sign_in "SG000001", "password"
    save_screenshot "scenario1-3_1.png"
    # 3.2. 整備作業一覧画面を開く
    click_link "整備一覧"
    save_screenshot "scenario1-3_2.png"
    # 3.3. 整備開始画面を開く
    click_link "開始登録"
    select "2014", from: "repair[estimated_finish_date(1i)]" # 予定完成日(年)
    select "1",    from: "repair[estimated_finish_date(2i)]" # 予定完成日(月)
    select "10",   from: "repair[estimated_finish_date(3i)]" # 予定完成日(日)
    comment = "整備がんばります！"
    fill_in "整備前コメント", with: comment
    click_button "整備開始"
    save_screenshot "scenario1-3_3.png"
    # 3.4. 整備作業一覧画面に移動する
    click_link "Back"
    within "tbody > tr" do
      #assert_equal comment, nth_tag(:td, 10).text  # 整備前コメント
      assert_equal "整備中", nth_tag(:td, 11).text # ステータス
    end
    save_screenshot "scenario1-3_4.png"
    # 3.9. サインアウトする
    sign_out

    ###########################################################################
    # 4. エンジン２の整備が完了した [@SG]
    ###########################################################################

    # 4.1. サインインする
    sign_in "SG000001", "password"
    save_screenshot "scenario1-4_1.png"
    # 4.2. 整備作業一覧画面を開く
    click_link "整備一覧"
    save_screenshot "scenario1-4_2.png"
    # 4.3. 整備完了画面を開く
    click_link "完了登録"
    select "2014", from: "repair[finish_date(1i)]" # 完了日(年)
    select "1",    from: "repair[finish_date(2i)]" # 完了日(月)
    select "9",    from: "repair[finish_date(3i)]" # 完了日(日)
    comment = "整備完了しました！"
    fill_in "完了時コメント", with: comment
    click_button "整備完了"
    save_screenshot "scenario1-4_3.png"
    # 4.4. 整備作業一覧画面に移動する
    click_link "Back"
    within "tbody > tr" do
      assert_equal "2014-01-09", nth_tag(:td, 7).text # 整備完了日
      #assert_equal comment, nth_tag(:td, 11).text     # 完成品コメント
      assert_equal "完成品", nth_tag(:td, 11).text    # ステータス
    end
    save_screenshot "scenario1-4_4.png"
    # 4.2. サインアウトする
    sign_out

    ###########################################################################
    # 5. エンジン１を使っているお客様から新たな引合が来た [@KT]
    ###########################################################################

    # 5.1. サインインする
    sign_in "KT000001", "password"
    save_screenshot "scenario1-5_1.png"
    # 5.2. 引合一覧画面を開く
    click_link "流通情報一覧"
    save_screenshot "scenario1-5_2.png"
    # 5.3. 引合登録画面を開く
    click_link "新規引合"
    save_screenshot "scenario1-5_3_1.png"
    fill_in "物件名", with: "ぶっけんめい"
    select "西宮戎リペア", from: "engineorder[branch_id]"           # 拠点
    select "法華倶楽部", from: "engineorder[install_place_id]"      # 設置先
    comment = "ちょっと調子がおかしいので交換してください。"
    fill_in "コメント(交換理由)", with: comment
    select "2014", from: "engineorder[desirable_delivery_date(1i)]" # 希望納期(年)
    select "2",    from: "engineorder[desirable_delivery_date(2i)]" # 希望納期(月)
    select "10",   from: "engineorder[desirable_delivery_date(3i)]" # 希望納期(日)
    save_screenshot "scenario1-5_3_2.png"
    click_button "引合登録"
    # 5.4. 引合一覧画面に移動する
    click_link "Back"
    within "tbody > tr" do
      assert_equal "引合", nth_tag(:td, 1).text         # ステータス
      assert_equal "西宮戎リペア", nth_tag(:td, 5).text # 拠点
      assert_equal "法華倶楽部", nth_tag(:td, 7).text   # 設置先
      assert_equal "2014-02-10", nth_tag(:td, 13).text  # 希望納期
    end
    save_screenshot "scenario1-5_4.png"
    # 5.9. サインアウトする
    sign_out

    ###########################################################################
    # 6. めでたくご発注頂いた [@KT]
    ###########################################################################

    # 6.1. サインインする
    sign_in "KT000001", "password"
    save_screenshot "scenario1-6_1.png"
    # 6.2. 引合一覧画面を開く
    click_link "流通情報一覧"
    save_screenshot "scenario1-6_2.png"
    # 6.3. 受注登録画面を開く
    click_link "受注登録"
    assert_equal "ぶっけんめい", find_field("物件名").value
    save_screenshot "scenario1-6_3_1.png"
    select "法華倶楽部", from: "engineorder[sending_place_id]" # 送付先
    save_screenshot "scenario1-6_3_2.png"
    click_button "受注登録"
    # 6.4. 引合一覧画面に移動する
    click_link "Back"
    within "tbody > tr" do
      assert_equal "受注", nth_tag(:td, 1).text        # ステータス
      assert_equal "法華倶楽部", nth_tag(:td, 12).text # 送付先
    end
    save_screenshot "scenario1-6_4.png"
    # 6.9. サインアウトする
    sign_out

    ###########################################################################
    # 7. エンジン２を引当てた (エンジン１の返却も兼ねる) [@AA]
    ###########################################################################

    # 7.1. サインインする
    sign_in "AA000001", "password"
    save_screenshot "scenario1-7_1.png"
    # 7.2. 引合一覧画面を開く
    click_link "流通情報一覧"
    save_screenshot "scenario1-7_2.png"
    # 7.3. 引当登録画面を開く
    click_link "引当登録"
    save_screenshot "scenario1-7_3_1.png"
    fill_in "物件名", with: "ぶっけんめい"
    select "1GPH00-KS ( 5 )", from: "返却エンジン"
    select "ENG0002 ( SN0001 )", from: "新規エンジン"
    select "2014", from: "engineorder[day_of_test(1i)]" # 試運転日(年)
    select "2",    from: "engineorder[day_of_test(2i)]" # 試運転日(月)
    select "20",   from: "engineorder[day_of_test(3i)]" # 試運転日(日)
    save_screenshot "scenario1-7_3_2.png"
    click_button "引当登録"
    # 7.4. 引合一覧画面に移動する
    click_link "Back"
    within "tbody > tr" do
      assert_equal "出荷準備中", nth_tag(:td, 1).text # ステータス
      assert_equal "1GPH00-KS ( 5 )", nth_tag(:td, 9).text # 返却エンジン
      assert_equal "ENG0002 ( SN0001 )", nth_tag(:td, 10).text # 新規エンジン
    end
    save_screenshot "scenario1-7_4.png"
    # 7.9. サインアウトする
    sign_out

    # SG からの出荷手続きが変更となった？
    # 流通情報一覧が開けない。。。
    # 流通情報一覧はアクセス不可に変更。整備一覧から出荷情報


    ###########################################################################
    # 8. エンジン２を出荷した [@SG]
    ###########################################################################

    # 8.1. サインインする
    sign_in "SG000001", "password"
    save_screenshot "scenario1-8_1.png"
    # 8.2. 整備一覧画面を開く
    click_link "整備一覧"
    save_screenshot "scenario1-8_2.png"
    # 8.3. 出荷登録画面を開く
    click_link "出荷登録"
    save_screenshot "scenario1-8_3_1.png"
    fill_in "送り状No（新エンジン）", with: "201312-001-001"
    save_screenshot "scenario1-8_3_2.png"
    click_button "出荷登録"
    # 8.4. 引合一覧画面に移動する
    click_link "戻る"
    within "tbody > tr" do
      assert_equal "出荷済", nth_tag(:td, 1).text # ステータス
      assert_equal "1GPH00-KS ( 5 )", nth_tag(:td, 9).text # 返却エンジン
      assert_equal "ENG0002 ( SN0001 )", nth_tag(:td, 10).text # 新規エンジン
    end
    save_screenshot "scenario1-8_4.png"
    # 8.2. サインアウトする
    sign_out
  end
end
