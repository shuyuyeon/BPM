using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Configuration;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using Ext.Net;
using System.Web;
using Newtonsoft.Json;
using System.Collections.Specialized;
using System.Net;
using System.Data.Common;


public class OFRUIShadow : IUIShadow
{
    // Declare controls which show in the web page
    #region form controls

    //store
    public Store storeNextStep; public Store storetouser; public Store storeQE; public Store storeselectCS; public Store storeCS;
    public Ext.Net.Panel frmcsInfo;
    public Ext.Net.Button butPrintYC;
    public Ext.Net.Button butAbort;

    //  user info
    public ComboBox cbUser; public ComboBox cbQE; public ComboBox cbTOUser;
    public ComboBox cbbCSFlag;

    //詳細信息
    public TextField txtOCAPNO;
    public TextField txtCLASSType;
    public TextField txtPRODUCT;
    public TextField txtSTEP;
    public TextField txtLOT;
    public TextField txtEQPNO;
    public ComboBox cbbShift;
    public TextField txtEMPID;
    public TextField txtQTY;
    public TextField txtLinecode;
    public TextField txtEVENTS;
    //原因
    public TextArea txtMS;
    public TextArea txtRootReason;
    public TextArea txtMaterial;

    //措施
    public Ext.Net.Button butAdd; public Ext.Net.Button butDel;
    public Radio rCSC; public Radio rDCS;
    public ComboBox cbCS;
    public TextField dfPE;
    public DateField dfDate;
    public TextArea txtCSRemark; //措施說明
    public GridPanel grdCSitems;
    public GridPanel grdLotInfo;

    //Events
    public Checkbox cOpen; public Checkbox cHold; public Checkbox cDown; public Checkbox cIPQC;
    public CheckboxGroup ckEvents;
    //处置结果
    public TextArea IPQCJY;
    public TextArea IPQCYZ;
    public TextArea QEJDXG;
    public TextArea QEGS;
    //public TextField txtIPQCs;
    // public TextField txtQEs;
    public TextArea txtabort;
    //簽字
    public TextField S_PE; public TextField S_PEKZ; public TextField S_PEManager; public TextField S_MFGLeader; public TextField S_MFGKZ; public TextField S_QE;
    public TextField S_QEKZ; public TextField S_QEManager;
    #endregion

    public OFRUIShadow(Page oContainer)
        : base(oContainer)
    { }
    private static Database _db { get; set; }
    public override void InitShadow(ContentPlaceHolder oContentPage)
    {
        #region form controls
        butAbort = (Ext.Net.Button)oContentPage.FindControl("butAbort");
        butPrintYC = (Ext.Net.Button)oContentPage.FindControl("butPrintYC");


        frmcsInfo = (Ext.Net.Panel)oContentPage.FindControl("frmcsInfo");

        cbbCSFlag = (ComboBox)oContentPage.FindControl("cbbCSFlag");

        //store
        storeNextStep = (Store)oContentPage.FindControl("storeNextStep");
        storetouser = (Store)oContentPage.FindControl("storetouser");
        storeQE = (Store)oContentPage.FindControl("storeQE");
        storeselectCS = (Store)oContentPage.FindControl("storeselectCS");
        storeCS = (Store)oContentPage.FindControl("storeCS");

        //  user info
        cbUser = (ComboBox)oContentPage.FindControl("cbUser");
        cbQE = (ComboBox)oContentPage.FindControl("cbQE");
        cbTOUser = (ComboBox)oContentPage.FindControl("cbTOUser");
        //詳細信息
        txtOCAPNO = (TextField)oContentPage.FindControl("txtOCAPNO");
        txtCLASSType = (TextField)oContentPage.FindControl("txtCLASSType");
        txtPRODUCT = (TextField)oContentPage.FindControl("txtPRODUCT");
        txtSTEP = (TextField)oContentPage.FindControl("txtSTEP");
        txtLOT = (TextField)oContentPage.FindControl("txtLOT");
        cbbShift = (ComboBox)oContentPage.FindControl("cbbShift");
        txtEMPID = (TextField)oContentPage.FindControl("txtEMPID");
        txtQTY = (TextField)oContentPage.FindControl("txtQTY");
        txtLinecode = (TextField)oContentPage.FindControl("txtLinecode");
        txtEQPNO = (TextField)oContentPage.FindControl("txtEQPNO");
        txtEVENTS = (TextField)oContentPage.FindControl("txtEVENTS");


        //原因
        txtMS = (TextArea)oContentPage.FindControl("txtMS");
        txtRootReason = (TextArea)oContentPage.FindControl("txtRootReason");
        txtMaterial = (TextArea)oContentPage.FindControl("txtMaterial");

        //措施
        butAdd = (Ext.Net.Button)oContentPage.FindControl("butAdd");
        butDel = (Ext.Net.Button)oContentPage.FindControl("butDel");
        rCSC = (Radio)oContentPage.FindControl("rCSC");
        rDCS = (Radio)oContentPage.FindControl("rDCS");
        dfPE = (TextField)oContentPage.FindControl("dfPE");
        dfDate = (DateField)oContentPage.FindControl("dfDate");
        txtCSRemark = (TextArea)oContentPage.FindControl("txtCSRemark");
        grdCSitems = (GridPanel)oContentPage.FindControl("grdCSitems");
        grdLotInfo = (GridPanel)oContentPage.FindControl("grdLotInfo");

        //Events
        ckEvents = (CheckboxGroup)oContentPage.FindControl("ckEvents");
        cOpen = (Checkbox)oContentPage.FindControl("cOpen");
        cHold = (Checkbox)oContentPage.FindControl("cHold");
        cDown = (Checkbox)oContentPage.FindControl("cDown");
        cIPQC = (Checkbox)oContentPage.FindControl("cIPQC");
        //处置结果
        IPQCJY = (TextArea)oContentPage.FindControl("IPQCJY");
        IPQCYZ = (TextArea)oContentPage.FindControl("IPQCYZ");
        QEJDXG = (TextArea)oContentPage.FindControl("QEJDXG");
        QEGS = (TextArea)oContentPage.FindControl("QEGS");
        IPQCJY = (TextArea)oContentPage.FindControl("IPQCJY");
        IPQCYZ = (TextArea)oContentPage.FindControl("IPQCYZ");
        //txtIPQCs = (TextField)oContentPage.FindControl("txtIPQCs");
        //txtQEs = (TextField)oContentPage.FindControl("txtQEs");
        txtabort = (TextArea)oContentPage.FindControl("txtabort");
        //簽字
        S_PE = (TextField)oContentPage.FindControl("S_PE");
        S_PEKZ = (TextField)oContentPage.FindControl("S_PEKZ");
        S_PEManager = (TextField)oContentPage.FindControl("S_PEManager");
        S_MFGLeader = (TextField)oContentPage.FindControl("S_MFGLeader");
        S_MFGKZ = (TextField)oContentPage.FindControl("S_MFGKZ");
        S_QE = (TextField)oContentPage.FindControl("S_QE");
        S_QEKZ = (TextField)oContentPage.FindControl("S_QEKZ");
        S_QEManager = (TextField)oContentPage.FindControl("S_QEManager");

        #endregion
    }
}
public class OFRLogics : ISPMInterfaceContent
{

    private Page oPage;
    private OFRUIShadow oUIControls;
    public IFormURLPara oPara;
    private SqlDB sdb = new SqlDB(DataPara.GetDbConnectionString("SPM"));
    private ArrayList opc = new ArrayList();
    private string sql = string.Empty;
    string _Stepid = string.Empty;
    public OFRLogics(object oContainer, IUIShadow UIShadow)
        : base(oContainer)
    {
        this.SetUIShadow(UIShadow);
    }

    protected override void PageLoad(object oContainer, IFormURLPara para, IUIShadow UIShadow)
    {
        oPage = (Page)oContainer;
        oPara = para;
        oUIControls = (OFRUIShadow)UIShadow;
        this.InitialPageControls();


        base.PageLoad(oContainer, para, UIShadow);
    }

    private void InitialPageControls()
    {
        if (!oPage.IsPostBack)
        {

        }
        try
        {
            if (!oPage.IsPostBack)
            {
                if (oPara.TaskId < 0)
                {
                    InitialControl_UserInfo();
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        finally
        {

        }

    }

    private void InitialControl_UserInfo()
    {
        //新开单加载开单人基本信息
        #region
        //if (string.IsNullOrEmpty(oPara.LoginId)) return;
        //SPMBasic SPMBasic_class = new SPMBasic();
        //Model_SPMUserInfo SPMUserInfo = new Model_SPMUserInfo();
        //SPMBasic_class.GetUserInfoByEName(oPara.LoginId, SPMUserInfo);
        //if (SPMUserInfo.Exists == true)
        //{
        //    oUIControls.txtEnglishName.Text = SPMUserInfo.cust_12;
        //    oUIControls.txtLogonID.Text = SPMUserInfo.logonID;
        //    oUIControls.txtName.Text = SPMUserInfo.userName;
        //    oUIControls.txtEMail.Text = SPMUserInfo.email;
        //    oUIControls.txtDept.Text = SPMUserInfo.deptName;
        //    oUIControls.txtExtNO.Text = SPMUserInfo.tel_office;
        //    oUIControls.txtBU.Text = SPMUserInfo.bu;

        //}
        ////初始化表單號
        //oUIControls.txtFormNO.Text = SPMBasic_class.GetSPMFormNO("SCM");
        #endregion

    }

    // Code for 'draft' and 'pending for process'，绑定控件内值与控制Hidden.ReadOnly，OK
    public override void InitialContainer(SPMTaskVariables SPMTaskVars, EFFormFields FormFields, ref object oContainer, IUIShadow UIShadow)
    {
        OFRUIShadow lUIControls = (OFRUIShadow)UIShadow;
        Model_SPMUserInfo SPMUserInfo = new Model_SPMUserInfo();
        _Stepid = SPMTaskVars.ReadDatum("STEPNAME").ToString();
        string _Resign = (string)(SPMTaskVars.ReadDatum("SYS_LOGONID"));//转发人员签名问题，SPMVa


        //基本信息加載後不可編輯
        //lUIControls.cbUser.Text = lUIControls.storetouser预设带下位签核人第一位
        lUIControls.txtOCAPNO.Text = FormFields["txtOCAPNO".ToUpper()]; lUIControls.txtOCAPNO.ReadOnly = true;
        lUIControls.txtPRODUCT.Text = FormFields["txtPRODUCT".ToUpper()]; lUIControls.txtPRODUCT.ReadOnly = true;
        lUIControls.txtCLASSType.Text = FormFields["txtCLASSType".ToUpper()];
        lUIControls.txtSTEP.Text = FormFields["txtSTEP".ToUpper()]; lUIControls.txtSTEP.ReadOnly = true;
        lUIControls.txtLOT.Text = FormFields["txtLOT".ToUpper()]; lUIControls.txtLOT.ReadOnly = true;
        lUIControls.txtEMPID.Text = FormFields["txtEMPID".ToUpper()]; lUIControls.txtEMPID.ReadOnly = true;
        lUIControls.txtEQPNO.Text = FormFields["txtEQPNO".ToUpper()]; lUIControls.txtEQPNO.ReadOnly = true;
        lUIControls.txtQTY.Text = FormFields["txtQTY".ToUpper()]; lUIControls.txtQTY.ReadOnly = true;
        lUIControls.txtLinecode.Text = FormFields["txtLinecode".ToUpper()]; lUIControls.txtLinecode.Hidden = true;
        lUIControls.txtEVENTS.Text = FormFields["txtEVENTS".ToUpper()]; lUIControls.txtEVENTS.Hidden = true;
        lUIControls.cbbShift.ReadOnly = true;
        //lUIControls.txtMaterial.Text = FormFields["txtMaterial".ToUpper()];在PE阶段还未有值，应在!=PE阶段载入                //从上一步填写后进对应表后由引擎抓到FORMVAR
        lUIControls.txtMaterial.ReadOnly = true;
        //原因
        Root OC  = JsonConvert.DeserializeObject<Root>(FormFields["txtReasonCode".ToUpper()].Replace("[", "").Replace("]", ""));
        lUIControls.txtMS.Text = OC.VALUE;          //FormFields["txtMS".ToUpper()];没值，FormFields["txtReason_Code".ToUpper()];报错
        lUIControls.txtMS.ReadOnly = true;
        //PE 可修改
        lUIControls.txtRootReason.ReadOnly = true;
        //措施
        //lUIControls.txtCSRemark.ReadOnly = true;
        //lUIControls.dfDate.ReadOnly = true;
        //lUIControls.dfPE.ReadOnly = true;
        //lUIControls.rCSC.ReadOnly = true;
        //lUIControls.rDCS.ReadOnly = true;
        lUIControls.butAdd.Hidden = true; lUIControls.butDel.Hidden = true;
        //lUIControls.frmcsInfo.Hidden = true;

        lUIControls.cbbCSFlag.ReadOnly = true;
        //Events
        if (lUIControls.txtEVENTS.Text.Contains("HOLD"))
        {
            lUIControls.cHold.Checked = true;
        }
        if (lUIControls.txtEVENTS.Text.Contains("OPENCARD"))//FormFields并不知道我tb_ocap_main表有哪些栏位，透过FORMVAR表的VARDATA栏位一次性抓取tb_ocap_main表全字段键值对
        {
            lUIControls.cOpen.Checked = true;
        }
        if (lUIControls.txtEVENTS.Text.Contains("DOWN"))
        {
            lUIControls.cDown.Checked = true;
        }
        if (lUIControls.txtEVENTS.Text.Contains("IPQC"))
        {
            lUIControls.cIPQC.Checked = true;
        }
        lUIControls.cOpen.ReadOnly = true;
        lUIControls.cHold.ReadOnly = true;
        lUIControls.cDown.ReadOnly = true;
        lUIControls.cIPQC.ReadOnly = true;
        lUIControls.ckEvents.ReadOnly = true;

        //处置结果
        lUIControls.IPQCJY.ReadOnly = true;
        lUIControls.IPQCYZ.ReadOnly = true;
        lUIControls.QEJDXG.ReadOnly = true;
        lUIControls.QEGS.ReadOnly = true;

        lUIControls.txtabort.ReadOnly = false;//原true,InitialDisableContainer内还有个没有改为false

        //  BindGrd(lUIControls.grdCSitems, GetCS(FormFields["txtOCAPNO".ToUpper()])); 
        BindGrd(lUIControls.grdLotInfo, GetLots(FormFields["txtOCAPNO".ToUpper()]));//材料追溯，不分职位都显示

        //簽字
        lUIControls.S_PE.ReadOnly = true;
        lUIControls.S_MFGKZ.ReadOnly = true;
        lUIControls.S_PEKZ.ReadOnly = true;
        lUIControls.S_PEManager.ReadOnly = true;
        lUIControls.S_QE.ReadOnly = true;
        lUIControls.S_QEKZ.ReadOnly = true;
        lUIControls.S_QEManager.ReadOnly = true;

        lUIControls.cbQE.Hidden = true;
        lUIControls.cbTOUser.Hidden = true;//转发人员预设隐藏，只在PE开启

        lUIControls.butPrintYC.Hidden = true;
        lUIControls.butAbort.Hidden = false;//原true


        if (_Stepid != "PE")//所以转发的时候班别才没带出，转发了就是要给别人填
        {
            //DataTable redt = GetResign(oPara.LoginId);//getOCAPMain(lUIControls.txtOCAPNO.Text);
            //加载起单后输入数据
            lUIControls.cbbShift.Text = FormFields["cbbShift".ToUpper()];
            lUIControls.IPQCJY.Text = FormFields["IPQCJY".ToUpper()];
            lUIControls.txtRootReason.Text = FormFields["txtRootReason".ToUpper()];                //这两句应在
            lUIControls.txtMaterial.Text = FormFields["txtMaterial".ToUpper()];                    //这里读取？从上面移下来？只是在起单时没insert到<txt>
            lUIControls.IPQCYZ.Text = FormFields["IPQCYZ".ToUpper()];
            lUIControls.QEJDXG.Text = FormFields["QEJDXG".ToUpper()];
            lUIControls.QEGS.Text = FormFields["QEGS".ToUpper()];
            lUIControls.S_PE.Text = FormFields["S_PE".ToUpper()];
            lUIControls.S_MFGLeader.Text = FormFields["S_MFGLeader".ToUpper()];
            lUIControls.S_MFGKZ.Text = FormFields["S_MFGKZ".ToUpper()];
            lUIControls.S_PEKZ.Text = FormFields["S_PEKZ".ToUpper()];
            //RM.MFG-Leader修改
            lUIControls.S_PEManager.Text = FormFields["S_PEManager".ToUpper()];
            lUIControls.S_QE.Text = FormFields["S_QE".ToUpper()];
            lUIControls.S_QEKZ.Text = FormFields["S_QEKZ".ToUpper()];                       //RM，我这次这些结构的不同点在于1我转发的人非同职务2，
            lUIControls.S_QEManager.Text = FormFields["S_QEManager".ToUpper()];//要在QC当前阶段赋值S_QEManager
            //lUIControls.S_MFGLeader.Text = _Resign;   //要添加判断比对从表select ename , role where ename = '_Resign' if role = "MFG-Leader" 就执行这句
        }


        #region //綁定各站簽核人
        if (_Stepid == "PE")
        {
            BindSign(FormFields["txtLinecode".ToUpper()], "MFG-Supervisor");
            BindSignToUser(FormFields["txtLinecode".ToUpper()], FormFields["txtSTEP".ToUpper()], oPara.LoginId);//绑转发人员MFG-Leader，BindSignToUser(FormFields["txtLinecode".ToUpper()], "PE");改成调用我添加的可转发'MFG-Leader','PE','RM'方法

            lUIControls.cbTOUser.Hidden = false;
            lUIControls.S_PE.Text = oPara.LoginId;//lUIControls.S_MFGLeader.Text这应该要改，FormFields["S_PE".ToUpper()]
            lUIControls.IPQCJY.ReadOnly = false;
            lUIControls.IPQCYZ.ReadOnly = false;
            lUIControls.cbbShift.ReadOnly = false;
            lUIControls.IPQCYZ.ReadOnly = false;
            lUIControls.butPrintYC.Hidden = false;
            lUIControls.butAbort.Hidden = false;
            lUIControls.IPQCYZ.ReadOnly = false;
            lUIControls.txtRootReason.ReadOnly = false;
            lUIControls.txtMaterial.ReadOnly = false;
            //lUIControls.S_MFGLeader.Text = _Resign;
            DataTable redt = GetResign(oPara.LoginId);//getOCAPMain(lUIControls.txtOCAPNO.Text);
            if (redt.Rows[0]["Role"].ToString() == "RM")
            {
                lUIControls.S_QEKZ.Text = oPara.LoginId;                       //改RM，我这次这些结构的不同点在于1我转发的人非同职务2，
                lUIControls.S_PE.Text = FormFields["S_PE".ToUpper()];
                lUIControls.S_MFGLeader.Text = FormFields["S_MFGLeader".ToUpper()];
            }
            if (redt.Rows[0]["Role"].ToString() == "MFG-Leader")
            {
                lUIControls.S_MFGLeader.Text = _Resign;   //要添加判断比对从表select ename , role where ename = '_Resign' if role = "MFG-Leader" 就执行这句
                lUIControls.S_PE.Text = FormFields["S_PE".ToUpper()];
                lUIControls.S_QEKZ.Text = FormFields["S_QEKZ".ToUpper()]; //RM是有带出，看下set formfield的地方（AfterSend）
            }
                
        }
        else
        {
            ////加载起单后输入数据
            //lUIControls.cbbShift.Text = FormFields["cbbShift".ToUpper()];
            //lUIControls.IPQCJY.Text = FormFields["IPQCJY".ToUpper()];
            //lUIControls.txtRootReason.Text = FormFields["txtRootReason".ToUpper()];
            //lUIControls.IPQCYZ.Text = FormFields["IPQCYZ".ToUpper()];
            //lUIControls.QEJDXG.Text = FormFields["QEJDXG".ToUpper()];
            //lUIControls.QEGS.Text = FormFields["QEGS".ToUpper()];
            //lUIControls.S_PE.Text = FormFields["S_PE".ToUpper()];
            //lUIControls.S_MFGLeader.Text = FormFields["S_MFGLeader".ToUpper()];
            //lUIControls.S_MFGKZ.Text = FormFields["S_MFGKZ".ToUpper()];
            //lUIControls.S_PEKZ.Text = FormFields["S_PEKZ".ToUpper()];
            //lUIControls.S_PEManager.Text = FormFields["S_PEManager".ToUpper()];
            //lUIControls.S_QE.Text = FormFields["S_QE".ToUpper()];
            //lUIControls.S_QEKZ.Text = FormFields["S_QEKZ".ToUpper()];
            //lUIControls.S_QEManager.Text = FormFields["S_QEManager".ToUpper()];



            if (_Stepid == "MFG-Supervisor")
            {
                BindSign(FormFields["txtLinecode".ToUpper()], "PE-Supervisor");
                lUIControls.S_MFGKZ.Text = oPara.LoginId;
            }
            if (_Stepid == "PE")//这if的内容常州这情况到PE-Supervisor需要
            {
                //type 3 輕 2 中 1 重
                if (lUIControls.txtCLASSType.Text.ToUpper() == "CLASS_III")
                {
                    BindSign(FormFields["txtLinecode".ToUpper()], "MFG-Leader");//没有这个，改成隐藏下步签核人的代码
                }
                if (lUIControls.txtCLASSType.Text.ToUpper() == "CLASS_II")
                {
                    BindSign(FormFields["txtLinecode".ToUpper()], "MFG-Supervisor");//QE
                }
                if (lUIControls.txtCLASSType.Text.ToUpper() == "CLASS_I")
                {
                    BindSign(FormFields["txtLinecode".ToUpper()], "MFG-Supervisor");//PE-Supervisor
                }
                //转发
                //BindSignToUser(FormFields["txtLinecode".ToUpper()], "PE");
                lUIControls.frmcsInfo.Hidden = false;
                if (lUIControls.txtCLASSType.Text.ToUpper() == "CLASS_III")
                {
                    lUIControls.cbQE.Hidden = true;
                }
                else
                {
                    lUIControls.cbQE.Hidden = false;
                }

                lUIControls.cbTOUser.Hidden = false;
                lUIControls.S_PE.Text = oPara.LoginId;

                lUIControls.txtMS.ReadOnly = false;
                lUIControls.txtRootReason.ReadOnly = false;
                lUIControls.txtCSRemark.ReadOnly = false;
                lUIControls.dfDate.ReadOnly = false;
                lUIControls.dfPE.ReadOnly = false;
                lUIControls.rCSC.ReadOnly = false;
                lUIControls.rDCS.ReadOnly = false;
                lUIControls.butAdd.Hidden = false; lUIControls.butDel.Hidden = false;


                //绑定措施
                oUIControls.storeselectCS.DataSource = GetSignCS("2019-01-01");   //改日期
                oUIControls.storeselectCS.DataBind();
                //绑定QE
                oUIControls.storeQE.DataSource = GetSign(FormFields["txtLinecode".ToUpper()], "QE");//不用
                oUIControls.storeQE.DataBind();

            }
            if (_Stepid == "PE-Supervisor")
            {
                if (lUIControls.txtCLASSType.Text.ToUpper() == "CLASS_II")
                {
                    BindSign(FormFields["txtLinecode".ToUpper()], "QE");
                }
                if (lUIControls.txtCLASSType.Text.ToUpper() == "CLASS_I")
                {
                    BindSign(FormFields["txtLinecode".ToUpper()], "PE-Manage");
                }
                //BindSign(FormFields["txtLinecode".ToUpper()], "");
                lUIControls.S_PEKZ.Text = oPara.LoginId;
            }
            if (_Stepid == "PE-Manage")
            {
                //無須指定簽核人員，常州要，我添加上
                BindSign(FormFields["txtLinecode".ToUpper()], "QE");
                lUIControls.S_PEManager.Text = oPara.LoginId;

            }
            if (_Stepid == "QE")
            {

                if (lUIControls.txtCLASSType.Text.Contains("I"))//没错，如果最严重就，这判断有误
                {
                    BindSign(FormFields["txtLinecode".ToUpper()], "QC");//原QE-Supervisor
                }
                //BindSignToUser(FormFields["txtLinecode".ToUpper()], "QE");//不用
                //if (lUIControls.txtCLASSType.Text.ToUpper() == "CLASS_II") lUIControls.cbUser.Hidden = true;   (虽说)跟PE在CLASS_III不隐藏是同理(PE.QE换人可能搞不清楚状况)，签核路径.检查填写为主，绑定.隐藏为辅
                lUIControls.S_QE.Text = oPara.LoginId;
                lUIControls.IPQCYZ.ReadOnly = false;
                lUIControls.QEJDXG.ReadOnly = false;
                lUIControls.QEGS.ReadOnly = false;


                lUIControls.cbbCSFlag.ReadOnly = false;


            }
            if (_Stepid == "QC")//QE-Supervisor
            {
                BindSign(FormFields["txtLinecode".ToUpper()], "QE-Manage");
                lUIControls.S_QEManager.Text = oPara.LoginId;

            }
            if (_Stepid == "QE-Manage")
            {
                lUIControls.cbUser.Hidden = true;
                //lUIControls.S_QEManager.Text = oPara.LoginId;//QE-Manage.QE-Supervisor(课长)同一位?暂时QC显示
            }

            if (_Stepid == "MFG-Leader2")
            {
                lUIControls.cbTOUser.Hidden = true;
                lUIControls.cbUser.Hidden = true;

            }


            #endregion

            if (_Stepid == "PE")
            {

                lUIControls.txtCSRemark.ReadOnly = false;
                lUIControls.dfDate.ReadOnly = false;
                lUIControls.dfPE.ReadOnly = false;
                lUIControls.rCSC.Enabled = true;
                lUIControls.rDCS.Enabled = true;
            }
        }




        base.InitialContainer(SPMTaskVars, FormFields, ref oContainer, UIShadow);
    }


    // Code for 'Notice' and 'Log'. Disable all contols.
    public override void InitialDisableContainer(SPMTaskVariables SPMTaskVars, EFFormFields FormFields, ref object oContainer, IUIShadow UIShadow)
    {
        OFRUIShadow lUIControls = (OFRUIShadow)UIShadow;
        //user info
        //基本信息加載後不可編輯
        lUIControls.txtOCAPNO.Text = FormFields["txtOCAPNO".ToUpper()]; lUIControls.txtOCAPNO.ReadOnly = true;
        lUIControls.txtPRODUCT.Text = FormFields["txtPRODUCT".ToUpper()]; lUIControls.txtPRODUCT.ReadOnly = true;
        lUIControls.txtCLASSType.Text = FormFields["txtCLASSType".ToUpper()];
        lUIControls.txtSTEP.Text = FormFields["txtSTEP".ToUpper()]; lUIControls.txtSTEP.ReadOnly = true;
        lUIControls.txtLOT.Text = FormFields["txtLOT".ToUpper()]; lUIControls.txtLOT.ReadOnly = true;
        lUIControls.txtEMPID.Text = FormFields["txtEMPID".ToUpper()]; lUIControls.txtEMPID.ReadOnly = true;
        lUIControls.txtEQPNO.Text = FormFields["txtEQPNO".ToUpper()]; lUIControls.txtEQPNO.ReadOnly = true;
        lUIControls.txtQTY.Text = FormFields["txtQTY".ToUpper()]; lUIControls.txtQTY.ReadOnly = true;
        lUIControls.txtLinecode.Text = FormFields["txtLinecode".ToUpper()]; lUIControls.txtLinecode.Hidden = true;
        lUIControls.txtEVENTS.Text = FormFields["txtEVENTS".ToUpper()]; lUIControls.txtEVENTS.Hidden = true;
        lUIControls.cbbShift.ReadOnly = true;
        //原因
        lUIControls.txtMS.Text = FormFields["txtMS".ToUpper()];//测试看看InitialContainer内有修改这不修改，结果是？
        lUIControls.txtMS.ReadOnly = true;
        //PE 可修改
        lUIControls.txtRootReason.ReadOnly = true; lUIControls.txtRootReason.Text = FormFields["txtEVENTS".ToUpper()];//材料追溯？
        //措施
        lUIControls.txtCSRemark.ReadOnly = true;
        lUIControls.dfDate.ReadOnly = true;
        lUIControls.dfPE.ReadOnly = true;
        lUIControls.rCSC.ReadOnly = true;
        lUIControls.rDCS.ReadOnly = true;
        lUIControls.butAdd.Hidden = true; lUIControls.butDel.Hidden = true;

        //Events
        if (lUIControls.txtEVENTS.Text.Contains("HOLD"))
        {
            lUIControls.cHold.Checked = true;
        }
        if (lUIControls.txtEVENTS.Text.Contains("OPENCARD"))
        {
            lUIControls.cOpen.Checked = true;
        }
        if (lUIControls.txtEVENTS.Text.Contains("DOWN"))
        {
            lUIControls.cDown.Checked = true;
        }
        if (lUIControls.txtEVENTS.Text.Contains("IPQC"))
        {
            lUIControls.cIPQC.Checked = true;
        }
        lUIControls.cOpen.ReadOnly = true;
        lUIControls.cHold.ReadOnly = true;
        lUIControls.cDown.ReadOnly = true;
        lUIControls.cIPQC.ReadOnly = true;
        lUIControls.ckEvents.ReadOnly = true;

        //处置结果
        lUIControls.IPQCJY.ReadOnly = true;
        lUIControls.IPQCYZ.ReadOnly = true;
        lUIControls.QEJDXG.ReadOnly = true;
        lUIControls.QEGS.ReadOnly = true;
        lUIControls.IPQCJY.ReadOnly = true;
        lUIControls.IPQCYZ.ReadOnly = true;
        lUIControls.txtabort.ReadOnly = true;

        /*BindGrd(lUIControls.grdCSitems, GetCS(FormFields["txtOCAPNO".ToUpper()]));*/
        BindGrd(lUIControls.grdLotInfo, GetLots(FormFields["txtOCAPNO".ToUpper()]));//材料追溯，不分职位都显示

        //簽字
        lUIControls.S_PE.ReadOnly = true;
        lUIControls.S_MFGKZ.ReadOnly = true;
        lUIControls.S_PEKZ.ReadOnly = true;
        lUIControls.S_PEManager.ReadOnly = true;
        lUIControls.S_QE.ReadOnly = true;
        lUIControls.S_QEKZ.ReadOnly = true;
        lUIControls.S_QEManager.ReadOnly = true;

        lUIControls.cbQE.Hidden = true;
        lUIControls.cbTOUser.Hidden = true;
        lUIControls.cbUser.Hidden = true;
        lUIControls.frmcsInfo.Hidden = true;

        if (_Stepid == "PE")
        {

            lUIControls.txtCSRemark.ReadOnly = false;
            lUIControls.dfDate.ReadOnly = false;
            lUIControls.dfPE.ReadOnly = false;
            lUIControls.rCSC.Enabled = true;
            lUIControls.rDCS.Enabled = true;

        }

        //加载起单后输入数据
        lUIControls.cbbShift.Text = FormFields["cbbShift".ToUpper()];//检查值与FORMVAR哪个节点匹配,检查FORMVAR更新时机
        lUIControls.IPQCJY.Text = FormFields["IPQCJY".ToUpper()];//检查值与FORMVAR哪个节点匹配,

        //值无法加载从表中查找
        //加載欄位數據 直接抓取後台數據

        DataTable s_dt = getOCAPMain(lUIControls.txtOCAPNO.Text);
        lUIControls.txtRootReason.Text = s_dt.Rows[0]["RootReason"].ToString();//没执行到？还是被刷新？拿去序列化给问题描述，材料处理没有数据源，由填写
        lUIControls.IPQCYZ.Text = s_dt.Rows[0]["IPQCCHeck"].ToString();
        lUIControls.QEJDXG.Text = s_dt.Rows[0]["QE_Result"].ToString();
        lUIControls.QEGS.Text = s_dt.Rows[0]["QE_ResultTrack"].ToString();
        lUIControls.S_PE.Text = s_dt.Rows[0]["S_PE"].ToString();
        lUIControls.S_MFGLeader.Text = s_dt.Rows[0]["S_MFGLader"].ToString();
        lUIControls.S_MFGKZ.Text = s_dt.Rows[0]["S_MFGKZ"].ToString();
        lUIControls.S_PEKZ.Text = s_dt.Rows[0]["S_PEKZ"].ToString();
        lUIControls.S_PEManager.Text = s_dt.Rows[0]["S_PEManager"].ToString();
        lUIControls.S_QE.Text = s_dt.Rows[0]["S_QE"].ToString();
        lUIControls.S_QEKZ.Text = s_dt.Rows[0]["S_QEKZ"].ToString();
        lUIControls.S_QEManager.Text = s_dt.Rows[0]["S_QEManager"].ToString();

        //簽字
        //lUIControls.S_PE.Text = s_dt.Rows[0]["S_PE"].ToString();
        //lUIControls.txtRootReason.Text = FormFields["txtRootReason".ToUpper()].ToString();
        //lUIControls.IPQCYZ.Text = FormFields["IPQCYZ".ToUpper()];
        //lUIControls.QEJDXG.Text = FormFields["QEJDXG".ToUpper()];
        //lUIControls.QEGS.Text = FormFields["QEGS".ToUpper()];
        //lUIControls.S_PE.Text = FormFields["S_PE".ToUpper()];
        //lUIControls.S_MFGLeader.Text = FormFields["S_MFGLeader".ToUpper()];
        //lUIControls.S_MFGKZ.Text = FormFields["S_MFGKZ".ToUpper()];
        //lUIControls.S_PEKZ.Text = FormFields["S_PEKZ".ToUpper()];
        //lUIControls.S_PEManager.Text = FormFields["S_PEManager".ToUpper()];
        //lUIControls.S_QE.Text = FormFields["S_QE".ToUpper()];
        //lUIControls.S_QEKZ.Text = FormFields["S_QEKZ".ToUpper()];
        //lUIControls.S_QEManager.Text = FormFields["S_QEManager".ToUpper()];




        base.InitialDisableContainer(SPMTaskVars, FormFields, ref oContainer, UIShadow);
    }

    //發送之前檢查，OK
    public override bool EFFormFieldsValidation(SPMSubmitMethod SubmitMethod, SPMProcessMethod ProcessMethod, SPMTaskVariables SPMTaskVars, ref IInterfaceHandleResult HandleResult, object oContainer, IUIShadow UIShadow)
    {

        Model_SPMUserInfo SPMUserInfo = new Model_SPMUserInfo();
        OFRUIShadow lUIControls = (OFRUIShadow)UIShadow;

        string stepName = (string)(SPMTaskVars.ReadDatum("STEPNAME"));

        if (stepName == "MFG-Leader")//PE
        {
            if (string.IsNullOrEmpty(lUIControls.cbUser.Text))
            {
                HandleResult.IsSuccess = false;
                HandleResult.CustomMessage += "▪必須選擇簽核人員";
                return true;
            }
            if (string.IsNullOrEmpty(lUIControls.cbbShift.RawText))
            {
                HandleResult.IsSuccess = false;
                HandleResult.CustomMessage += "▪班別必須選擇";
                return true;
            }
            if (string.IsNullOrEmpty(lUIControls.IPQCJY.RawText))
            {
                HandleResult.IsSuccess = false;
                HandleResult.CustomMessage += "▪材料檢驗必須輸入";
                return true;
            }


        }
        //上面是指finish.reject.abort？
        if (SubmitMethod.ToString().Contains("Approve"))//同位阶的有别的参数？Finish?
        {
            if (stepName == "MFG-Supervisor")
            {
                if (string.IsNullOrEmpty(lUIControls.cbUser.Text))//以这为例，如果到了MFG-Supervisor此阶段下任何RoutingVariable流程都有下位签核人(非End)，且Visible，最后才且动作非Reject
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage += "▪必須選擇簽核人員";
                    return true;
                }
            }

            if (stepName == "PE")
            {

                /*if (string.IsNullOrEmpty(lUIControls.cbUser.Text))
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage += "▪必须选择签核人员";//但如果有选择转发人员的话
                    return true;
                }*/
                if (lUIControls.txtCLASSType.Text.ToUpper() != "CLASS_III")//如果不是最轻等级，                                且显示要控制==CLASS_III要隐藏
                {
                    if (string.IsNullOrEmpty(lUIControls.cbUser.Text) && string.IsNullOrEmpty(lUIControls.cbTOUser.Text))
                    {
                        HandleResult.IsSuccess = false;
                        HandleResult.CustomMessage += "▪必須選擇轉發或簽核人員";//QE签核人员
                        return true;
                    }
                    /*else
                    {
                        lUIControls.S_QE.Text = lUIControls.cbQE.Text;
                    }*/
                }

                if (string.IsNullOrEmpty(lUIControls.cbbShift.RawText) && string.IsNullOrEmpty(lUIControls.cbTOUser.Text))    //即使是转发，也会要求要填，这是否会跟实际情况抵触；无论等级都要
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage += "▪班別必須選擇";
                    return true;
                }

                //获取前台措施明细数据（PE填完后才有）
                /*DataTable dt = System.Web.HttpContext.Current.Session["RequestTable"] as DataTable;
                if (dt.Rows.Count <= 0)
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage = "措施數據不存在無法送簽";
                    return true;
                }*/

                /*if (!string.IsNullOrEmpty(lUIControls.cbTOUser.Text) && !string.IsNullOrEmpty(lUIControls.cbUser.Text))
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage += "▪請擇一選擇轉發或簽核人員";
                    return true;
                }*/

                if (string.IsNullOrEmpty(lUIControls.txtRootReason.Text) && string.IsNullOrEmpty(lUIControls.cbTOUser.Text))
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage += "▪必須輸入根本原因";
                    return true;
                }
                if (string.IsNullOrEmpty(lUIControls.txtMaterial.Text) && string.IsNullOrEmpty(lUIControls.cbTOUser.Text))//我添加的
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage += "▪必須輸入材料處理";
                    return true;
                }
            }

            if (stepName == "QE")//20200921know level 需要修改，                              QE阶段相应控制显示隐藏待调整，QE-Manage的显示也调整
            {
                if (lUIControls.txtCLASSType.Text.ToUpper() == "CLASS_I")
                {
                    if (string.IsNullOrEmpty(lUIControls.cbUser.Text))
                    {
                        HandleResult.IsSuccess = false;
                        HandleResult.CustomMessage += "▪必須選擇簽核人員";
                        return true;
                    }
                }

                /*if (string.IsNullOrEmpty(lUIControls.cbUser.Text))
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage += "▪必须选择签核人员";
                    return true;
                }原先没判断导致阶段二仍然需要选，hidden更不行*/

                DataTable dt_ss = System.Web.HttpContext.Current.Session["RequestTable"] as DataTable;

                for (int g = 0; g < dt_ss.Rows.Count; g++)
                {
                    if (dt_ss.Rows[g]["CSFLAG"].ToString() == "")
                    {
                        HandleResult.IsSuccess = false;
                        HandleResult.CustomMessage = "是否追蹤必須填寫";//QE选择完是否要有产生追踪单号
                        return true;

                    }
                }

                //if (string.IsNullOrEmpty(lUIControls.IPQCYZ.Text))
                //{
                //    HandleResult.IsSuccess = false;
                //    HandleResult.CustomMessage += "▪必须输入(IPQC)驗證";
                //    return true;
                //}

                /*if (string.IsNullOrEmpty(lUIControls.QEJDXG.Text))
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage += "▪必须输入(QE)品質監督執行效果";
                    return true;
                }
                if (string.IsNullOrEmpty(lUIControls.QEGS.Text))
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage += "▪必须输入(QE)改善效果Tracking";
                    return true;
                }20200921注解*/
            }

            if (stepName == "PE-Supervisor")
            {
                if (lUIControls.txtCLASSType.Text.ToUpper() != "CLASS_III")
                {
                    if (string.IsNullOrEmpty(lUIControls.cbUser.Text))
                    {
                        HandleResult.IsSuccess = false;
                        HandleResult.CustomMessage += "▪必須選擇簽核人員";
                        return true;
                    }
                }
            }

            if (stepName == "PE-Manage")
            {
                if (string.IsNullOrEmpty(lUIControls.cbUser.Text))//以这为例，如果到了MFG-Supervisor此阶段下任何RoutingVariable流程都有下位签核人(非End)，且Visible，最后才且动作非Reject
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage += "▪必須選擇簽核人員";
                    return true;
                }
            }

            if(stepName == "QC")
            {
                if (string.IsNullOrEmpty(lUIControls.cbUser.Text))//以这为例，如果到了MFG-Supervisor此阶段下任何RoutingVariable流程都有下位签核人(非End)，且Visible，最后才且动作非Reject
                {
                    HandleResult.IsSuccess = false;
                    HandleResult.CustomMessage += "▪必須選擇簽核人員";
                    return true;
                }
            }

        }


        return base.EFFormFieldsValidation(SubmitMethod, ProcessMethod, SPMTaskVars, ref HandleResult, oContainer, UIShadow);
    }
    //FormFields里面有值从这来，而控件里面有值通过func
    public override void PrepareEFFormFields(SPMSubmitMethod SubmitMethod, SPMProcessMethod ProcessMethod, SPMTaskVariables TaskVars, ref EFFormFields FormFields, ref IInterfaceHandleResult HandleResult, object oContainer, IUIShadow UIShadow, ref string ApplicantInfo)
    {

        OFRUIShadow lUIControls = (OFRUIShadow)UIShadow;

        FormFields.SetOrAdd("txtOCAPNO".ToUpper(), lUIControls.txtOCAPNO.Text);
        FormFields.SetOrAdd("txtPRODUCT".ToUpper(), lUIControls.txtPRODUCT.Text);
        FormFields.SetOrAdd("txtCLASSType".ToUpper(), lUIControls.txtCLASSType.Text);
        FormFields.SetOrAdd("txtLOT".ToUpper(), lUIControls.txtLOT.Text);
        FormFields.SetOrAdd("txtEMPID".ToUpper(), lUIControls.txtEMPID.Text);
        FormFields.SetOrAdd("txtQTY".ToUpper(), lUIControls.txtQTY.Text);
        FormFields.SetOrAdd("txtLinecode".ToUpper(), lUIControls.txtLinecode.Text);
        FormFields.SetOrAdd("txtEQPNO".ToUpper(), lUIControls.txtEQPNO.Text);
        FormFields.SetOrAdd("txtEVENTS".ToUpper(), lUIControls.txtEVENTS.Text);


        FormFields.SetOrAdd("cbbShift".ToUpper(), lUIControls.cbbShift.Text);
        // FormFields.SetOrAdd("cbbShift".ToUpper(), lUIControls.cbbShift.SelectedIndex != -1 ? lUIControls.cbbShift.SelectedItem.Text.ToString().Trim() : lUIControls.cbbShift.SelectedItem.Text.ToString().Trim());
        FormFields.SetOrAdd("cbQE".ToUpper(), lUIControls.cbQE.SelectedIndex != -1 ? lUIControls.cbQE.SelectedItem.Text.ToString().Trim() : lUIControls.cbQE.SelectedItem.Text.ToString().Trim());
        FormFields.SetOrAdd("cbTOUser".ToUpper(), lUIControls.cbTOUser.SelectedIndex != -1 ? lUIControls.cbTOUser.SelectedItem.Text.ToString().Trim() : lUIControls.cbTOUser.SelectedItem.Text.ToString().Trim());
        FormFields.SetOrAdd("cbUser".ToUpper(), lUIControls.cbUser.SelectedIndex != -1 ? lUIControls.cbUser.SelectedItem.Text.ToString().Trim() : lUIControls.cbUser.SelectedItem.Text.ToString().Trim());
        //原因
        FormFields.SetOrAdd("txtMS".ToUpper(), lUIControls.txtMS.Text);//
        FormFields.SetOrAdd("txtRootReason".ToUpper(), lUIControls.txtRootReason.Text);
        FormFields.SetOrAdd("txtMaterial".ToUpper(), lUIControls.txtMaterial.Text);//
        ///處置結果
        FormFields.SetOrAdd("IPQCJY".ToUpper(), lUIControls.IPQCJY.Text);
        FormFields.SetOrAdd("IPQCYZ".ToUpper(), lUIControls.IPQCYZ.Text);
        // FormFields.SetOrAdd("Opinion_Date".ToUpper(), lUIControls.Opinion_Date.SelectedDate.ToString("yyyy-MM-dd"));  //Opinion_Date
        //MaterialProcess_Result 材料處理結果
        FormFields.SetOrAdd("QEJDXG".ToUpper(), lUIControls.QEJDXG.Text);
        FormFields.SetOrAdd("QEGS".ToUpper(), lUIControls.QEGS.Text);
        FormFields.SetOrAdd("txtabort".ToUpper(), lUIControls.txtabort.Text);
        // 簽字
        FormFields.SetOrAdd("S_PE".ToUpper(), lUIControls.S_PE.Text);
        FormFields.SetOrAdd("S_MFGLeader".ToUpper(), lUIControls.S_MFGLeader.Text);
        FormFields.SetOrAdd("S_MFGKZ".ToUpper(), lUIControls.S_MFGKZ.Text);
        FormFields.SetOrAdd("S_PEKZ".ToUpper(), lUIControls.S_PEKZ.Text);
        FormFields.SetOrAdd("S_PEManager".ToUpper(), lUIControls.S_PEManager.Text);
        FormFields.SetOrAdd("S_QE".ToUpper(), lUIControls.S_QE.Text);
        FormFields.SetOrAdd("S_QEKZ".ToUpper(), lUIControls.S_QEKZ.Text);                                    //，要改成RM，是赋值给S_QEKZ.Text的值在Approve后Vardate内会多一个第一个参数的节点
        FormFields.SetOrAdd("S_QEManager".ToUpper(), lUIControls.S_QEManager.Text);  //上一行未改动的情况下，除了formvar表外，main表能否正确更新？

        base.PrepareEFFormFields(SubmitMethod, ProcessMethod, TaskVars, ref FormFields, ref HandleResult, oContainer, UIShadow, ref ApplicantInfo);
    }
    //加上Reject部分暂时OK
    public override void PrepareSPMVariables(SPMSubmitMethod SubmitMethod, SPMProcessMethod ProcessMethod, SPMTaskVariables SPMTaskVars, ref SPMVariables Variables, ref SPMRoutingVariable RoutingVariable, ref string strSPMUid, string strMemo, string strNotesForNextApprover, EFFormFields FormFields, ref IInterfaceHandleResult HandleResult, ref string SuccessMessage)
    {

        DataTable dts = System.Web.HttpContext.Current.Session["CurrentTable"] as DataTable;//这是获取什么数据,追了是null
        //上面一句后续取用就是为了给FormFields吧
        //FormFields["cbUser"] = "brucegao";
        string Nextuser = FormFields["cbUser".ToUpper()].ToString();//运行时跑完PrepareEFFormFields后有值了
        string ToUser = FormFields["cbTOUser".ToUpper()].ToString();
        string Leave = FormFields["txtCLASSType".ToUpper()].ToString();
        string MFGLeader2 = FormFields["S_MFGLeader".ToUpper()].ToString();
        string QE = FormFields["S_QE".ToUpper()].ToString();//签核前没此子节点，在签核的过程中会updateFORMVAR表加上
        try
        {
            if (SubmitMethod == SPMSubmitMethod.HandleCase_Approve || SubmitMethod == SPMSubmitMethod.CreateNewCase)
            {
                //int attachCount = LiteOn.ea.SPM3G.SupportClass.Attach.GetAttachCount(oPara.CaseId);

                string Next_Step = string.Empty;
                switch (oPara.StepName)
                {
                    case "PE"://我的转发显示不因CLASS_(不过!=PE后我转发的就hide)所以我
                        if (ToUser != "")
                        {
                            RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "PE(" + ToUser + ")");//MFG-Leader
                        }
                        else
                        {
                            if (Leave == "Class_III")
                            {
                                RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "End");
                            }
                            else
                            {
                                RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "MFG-Supervisor(" + Nextuser + ")");
                            }
                        }
                        break;
                    case "MFG-Supervisor":
                        RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "PE-Supervisor(" + Nextuser + ")");
                        break;
                    case "PE-Supervisor":
                        if (ToUser != "")//PE-Supervisor没有转发人员
                        {
                            RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "PE(" + ToUser + ")");
                        }
                        else
                        {
                            if (Leave == "Class_II")
                            {
                                RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "QE(" + Nextuser + ")");
                            }

                            if (Leave == "Class_I")
                            {
                                RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "PE-Manage(" + Nextuser + ")");//FormFields["cbUser"]
                            }
                        }
                        break;
                    case "PE-Manage":
                        RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "QE(" + Nextuser + ")");
                        break;
                    /*case "QE":
                        RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "QE(" + QE + ")");
                        break;*/
                    case "QE":
                        if (ToUser != "")
                        {
                            RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "QE(" + ToUser + ")");
                        }
                        else
                        {
                            if (Leave == "Class_II")
                            {
                                RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "End");
                                //RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "MFG-Leader2(" + MFGLeader2 + ")");
                            }
                            if (Leave == "Class_I")
                            {
                                RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "QC(" + Nextuser + ")");
                            }
                        }
                        break;
                    case "QC"://QE-Supervisor
                        RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "QE-Manage(" + Nextuser + ")");
                        break;
                    case "QE-Manage":
                        RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "End");
                        //RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "MFG-Leader2(" + MFGLeader2 + ")");
                        break;
                    /*case "MFG-Leader2":
                        RoutingVariable = new SPMRoutingVariable(SPMRoutingVariableKey.spm_NextHandler, "End");
                        break;*/
                }
            }

            LogWriter.writeInfo("PrepareSPMVariables LogonID: " + oPara.LoginId + ", CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName);
        }
        catch (Exception ex)
        {
            LogWriter.writeError("PrepareSPMVariables LogonID: " + oPara.LoginId + ", CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName + ", ErrorMessage: " + ex.Message);
            throw new Exception(ex.Message);
        }

        base.PrepareSPMVariables(SubmitMethod, ProcessMethod, SPMTaskVars, ref Variables, ref RoutingVariable, ref strSPMUid, strMemo, strNotesForNextApprover, FormFields, ref HandleResult, ref SuccessMessage);
    }

    public override void SPMBeforeSend(SPMSubmitMethod SubmitMethod, SPMTaskVariables SPMTaskVars, SPMVariables Variables, SPMRoutingVariable RoutingVariable, ref EFFormFields FormFields, ref IInterfaceHandleResult HandleResult)
    {

        LogWriter.writeInfo("SPMBeforeSend LogonID: " + oPara.LoginId + ", CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName);
        base.SPMBeforeSend(SubmitMethod, SPMTaskVars, Variables, RoutingVariable, ref FormFields, ref HandleResult);
    }
    //update数据库签核到哪里签核人是谁，是否reject，reject的一些更新及签名问题
    public override void SPMAfterSend(SPMSubmitMethod SubmitMethod, SPMTaskVariables SPMTaskVars, SPMVariables Variables, SPMRoutingVariable RoutingVariable, EFFormFields FormFields, ref IInterfaceHandleResult HandleResult)
    {
        //这方法UnitTest仔细了解下
        //  LogWriter.writeInfo("SPMAfterSend LogonID: " + oPara.LoginId + ", CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName);
        if (RoutingVariable != null)   //追踪过这是null传入下面参数导致问题
        {
            string sRoutingData = string.Empty;
            switch (RoutingVariable.Key)//spm_NextHandler
            {
                case SPMRoutingVariableKey.spm_Return:                                                                //我这的reject待启用逻辑
                    sRoutingData = RoutingVariable.Data;//RoutingVariable.Data上站签核人/Key两个属性赋值追踪(是英文名)
                    break;
                case SPMRoutingVariableKey.spm_Jump:
                    break;
            }
        }
        // Business logic
        if (SubmitMethod != SPMSubmitMethod.CreateNewCase)//submit的那位，这里是CZWFAdmin
        {
            SPMAfterSend_DBIO(SPMTaskVars, FormFields, ref HandleResult, RoutingVariable);
        }

        base.SPMAfterSend(SubmitMethod, SPMTaskVars, Variables, RoutingVariable, FormFields, ref HandleResult);
    }
    //拿FormField的值去更新客制表
    private void SPMAfterSend_DBIO(SPMTaskVariables SPMTaskVars, EFFormFields FormFields, ref IInterfaceHandleResult HandleResult, SPMRoutingVariable RoutingVariable)
    {
        //Reject Abort 更新EDN系统表状态by DocumentNO
        string sCurLogonID = (string)(SPMTaskVars.ReadDatum("SYS_LOGONID"));//监看值，更换参数看看，还有stepname外还有什么
        //下站簽核人
        string nextstepuser = (string)(RoutingVariable.Data.ToString());

        switch (RoutingVariable.Key)
        {
            case SPMRoutingVariableKey.spm_Return:
                UpdateStatus(FormFields["TXTOCAPNO".ToUpper()].Trim(), "REJECT", nextstepuser);//reject的也更新为nextstepuser？
                //更新EDN状态
                //UpdateStatusForEDN(FormFields["TXTGINO"].Trim(), "REJECT");
                break;
            case SPMRoutingVariableKey.spm_NextHandler:
                string stepName = (string)(SPMTaskVars.ReadDatum("STEPNAME"));

                if (stepName == "MFG-Leader")
                {
                    UpdateMFGLeaderStatus(FormFields["TXTOCAPNO".ToUpper()].Trim(), "Pending", FormFields["cbbShift".ToUpper()].Trim(), FormFields["IPQCJY".ToUpper()].Trim(), FormFields["IPQCYZ".ToUpper()].Trim(), nextstepuser, FormFields["S_MFGLeader".ToUpper()].Trim());
                }
                if (stepName == "MFG-Supervisor")
                {
                    UpdateMFGKZ(FormFields["TXTOCAPNO".ToUpper()].Trim(), FormFields["S_MFGKZ".ToUpper()].Trim(), nextstepuser);
                }
                if (stepName == "PE")
                {
                    string txtMS = FormFields["txtMS".ToUpper()];
                    string txtRootReason = FormFields["txtRootReason".ToUpper()];
                    string txtMaterial = FormFields["txtMaterial".ToUpper()];
                    //更新主表，即使不在起单程式就update status依我看天津,检查这里面每个键的值
                    UpdatePE(FormFields["TXTOCAPNO".ToUpper()].Trim(), "Pending", FormFields["txtMS".ToUpper()].Trim(), FormFields["txtRootReason".ToUpper()].Trim(), FormFields["txtMaterial".ToUpper()].Trim(), FormFields["cbbShift".ToUpper()].Trim(), FormFields["S_PE".ToUpper()].Trim(), nextstepuser);//FormFields["S_PE"
                    //如果明细已经存在先删除后再新增加最新Session 数据
                    /*PEdelitems(FormFields["TXTOCAPNO".ToUpper()].Trim());*/

                    //获取前台措施明细数据添加到数据库
                    /*DataTable dt = System.Web.HttpContext.Current.Session["RequestTable"] as DataTable;
                    if (dt.Rows.Count > 0)
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {//insert into TB_OCAPItems
                            Common_WF.AddOCAP_Item(dt.Rows[i]["ID"].ToString(), FormFields["TXTOCAPNO".ToUpper()].Trim(), dt.Rows[i]["CS"].ToString(), dt.Rows[i]["CSPerson"].ToString(), dt.Rows[i]["CSDATE"].ToString(), dt.Rows[i]["TYPE"].ToString());
                        }

                    }*/

                    if (FormFields["txtCLASSType".ToUpper()] == "Class_III")
                    {
                        DataTable lots = CheckLotidExists(FormFields["TXTLOT".ToUpper()].Trim(), oPara.CaseId.ToString());
                        if (lots.Rows.Count <= 0)
                        {
                            UpdateStatusForEPT(FormFields["TXTLOT".ToUpper()].Trim(), "Release");

                            string message = string.Empty;
                            string EQPNO = FormFields["txtEQPNO".ToUpper()].Trim();
                            string lotid = "{\"Language\": \"EN\",\"LotId\": \"" + FormFields["TXTLOT".ToUpper()].Trim() + "\"}";
                            PostRelease("http://10.141.64.101:8020/MachineServiceHttp/EPT/ReleaseLot", lotid);
                            /*int date = new int();
                            bool isChangeSuccess = ReleaseLot.fwChangeState("no", "no", date,
                                                                                                                    oPara.LoginId, string.Empty, "ChangeState", "DOWN", EQPNO,
                                                                                                                     "down2idle", "IDLE", "CHG_EQP_STATE", "TJ", "1", "A-AM", "EQP_STATE", ref message);

                            // ("no", "no", DataOperate.GetTimeStamp(), SessionFacade.Username, txtStateComment.Text, "ChangeState", "IDLE", eqpId, "idle2run", "RUN", "CHG_EQP_STATE", schedule, scheduleVersion, "A-AM", "EQP_STATE", ref message);
                            if (isChangeSuccess == false)
                            {
                                HandleResult.IsSuccess = false;
                                HandleResult.CustomMessage += message;
                            }*/
                        }
                        UpdateStatus(FormFields["TXTOCAPNO".ToUpper()].Trim(), "Finished", oPara.LoginId.ToString());
                    }
                }

                if (stepName == "PE-Supervisor")
                {
                    UpdatePEKZ(FormFields["TXTOCAPNO".ToUpper()].Trim(), FormFields["S_PEKZ".ToUpper()].Trim(), nextstepuser);
                }

                if (stepName == "PE-Manage")
                {
                    UpdatePEJL(FormFields["TXTOCAPNO".ToUpper()].Trim(), FormFields["S_PEManager".ToUpper()].Trim(), nextstepuser);
                }

                /*if (stepName != "MFG-Leader" && stepName != "PE" && stepName != "QE")
                {
                    UpdateStatus(FormFields["TXTOCAPNO".ToUpper()].Trim(), "Pending", nextstepuser);

                }*这用途不明暂时注解/


                //保存追蹤方式，产生追踪单号？措施明细及QE部分都拿掉了，这块先注解掉
                /*if (stepName == "QE")
                {
                    DataTable dt_cs = System.Web.HttpContext.Current.Session["RequestTable"] as DataTable;
                    string csflag = string.Empty;
                    DataTable dt = new DataTable();
                    string sql = "select *  from  TB_OCAPItems  where ocapno=@ocapno    ";
                    ArrayList opc = new ArrayList();
                    opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, FormFields["TXTOCAPNO".ToUpper()].Trim()));
                    SqlDB sdb = new SqlDB(DataPara.GetDbConnectionString("SPM"));
                    dt = sdb.GetDataTable(sql, opc);
                    if (dt.Rows.Count > 0)
                    {
                        for (int g = 0; g < dt_cs.Rows.Count; g++)
                        {
                            dt_cs.Rows[g]["CSFLAG"].ToString();
                            //更新是否追蹤
                            UpdateQECSItems(FormFields["TXTOCAPNO".ToUpper()].Trim(), dt_cs.Rows[g]["ID"].ToString(), dt_cs.Rows[g]["CSFLAG"].ToString());
                        }
                    }
                    UpdateQE(FormFields["TXTOCAPNO".ToUpper()].Trim(), FormFields["S_QE".ToUpper()].Trim(), FormFields["IPQCYZ".ToUpper()].Trim(), FormFields["QEJDXG".ToUpper()].Trim(), FormFields["QEGS".ToUpper()].Trim(), nextstepuser);
                }*/

                /*if (stepName == "QC")//QE-Supervisor
                {
                    UpdateQEKZ(FormFields["TXTOCAPNO".ToUpper()].Trim(), FormFields["S_QEKZ".ToUpper()].Trim(), nextstepuser);//检查看在此前的FormFields["S_QEKZ"]值
                }*/

                if (stepName == "QE")//QE-Manage
                {
                    UpdateQE(FormFields["TXTOCAPNO".ToUpper()].Trim(), FormFields["S_QE".ToUpper()].Trim(), nextstepuser);

                    if (FormFields["txtCLASSType".ToUpper()] == "Class_II")
                    {
                        DataTable lots = CheckLotidExists(FormFields["TXTLOT".ToUpper()].Trim(), oPara.CaseId.ToString());
                        if (lots.Rows.Count <= 0)
                        {
                            UpdateStatusForEPT(FormFields["TXTLOT".ToUpper()].Trim(), "Release");

                            string message = string.Empty;
                            string EQPNO = FormFields["txtEQPNO".ToUpper()].Trim();
                            string lotid = "{\"Language\": \"EN\",\"LotId\": \"" + FormFields["TXTLOT".ToUpper()].Trim() + "\"}";
                            PostRelease("http://10.141.64.101:8020/MachineServiceHttp/EPT/ReleaseLot", lotid);
                            /*int date = new int();
                            bool isChangeSuccess = ReleaseLot.fwChangeState("no", "no", date,
                                                                                                                    oPara.LoginId, string.Empty, "ChangeState", "DOWN", EQPNO,
                                                                                                                     "down2idle", "IDLE", "CHG_EQP_STATE", "TJ", "1", "A-AM", "EQP_STATE", ref message);

                            // ("no", "no", DataOperate.GetTimeStamp(), SessionFacade.Username, txtStateComment.Text, "ChangeState", "IDLE", eqpId, "idle2run", "RUN", "CHG_EQP_STATE", schedule, scheduleVersion, "A-AM", "EQP_STATE", ref message);
                            if (isChangeSuccess == false)
                            {
                                HandleResult.IsSuccess = false;
                                HandleResult.CustomMessage += message;
                            }*/
                        }
                        UpdateStatus(FormFields["TXTOCAPNO".ToUpper()].Trim(), "Finished", oPara.LoginId.ToString());
                    }
                }

                if (stepName == "QC")
                {
                    UpdateQC(FormFields["TXTOCAPNO".ToUpper()].Trim(), FormFields["S_QC".ToUpper()].Trim(), nextstepuser); //S_QEManager，跑完到main表看，这在正式区此函数内更新的栏位名要改
                }

                //end step
                if (stepName == "QE-Manage")//MFG-Leader2，Release动作在里面，唯我这边流程最后一位签核人非固定，要依CLASS_
                {
                    UpdateQEJL(FormFields["TXTOCAPNO".ToUpper()].Trim(), FormFields["S_QEManager".ToUpper()].Trim(), nextstepuser);
                    //都要流程结束， 
                    //如同时到mfg-leader2 2张以上，签核到最后一张再做release  , 2张哪张先签核完毕，就先流程结束，不做release
                    //检查签核中是否还有
                    DataTable lots = CheckLotidExists(FormFields["TXTLOT".ToUpper()].Trim(), oPara.CaseId.ToString());
                    if (lots.Rows.Count <= 0)
                    {
                        ////Release  主 lot 
                        //if (ReleaseLot.GetLotStatus(FormFields["TXTLOT".ToUpper()].Trim()))
                        //    ReleaseLot.LotRelease(FormFields["TXTLOT".ToUpper()].Trim(), oPara.LoginId, FormFields["txtMS".ToUpper()].Trim(), "WF_OCAPFARRI", FormFields["TXTOCAPNO".ToUpper()].Trim());
                        //// Release 相关lot
                        //DataTable _itemsLot = getItemLots(FormFields["TXTOCAPNO".ToUpper()].Trim());
                        //if (_itemsLot.Rows.Count > 0)
                        //{
                        //    for (int i = 0; i < _itemsLot.Rows.Count; i++)
                        //    {
                        //        if (ReleaseLot.GetLotStatus(_itemsLot.Rows[i]["LotId"].ToString()))
                        //            ReleaseLot.LotRelease(_itemsLot.Rows[i]["LotId"].ToString(), oPara.LoginId, FormFields["txtMS".ToUpper()].Trim(), "WF_OCAPFARRI", FormFields["TXTOCAPNO".ToUpper()].Trim());
                        //    }
                        //}

                        //2020323  hell change table: LEDWAITINGANALYZE  by  TXTOCAPNO
                        UpdateStatusForEPT(FormFields["TXTLOT".ToUpper()].Trim(), "Release");

                        // "down2run", "IDLE", "OPACFAR", "TJ", "1", "A", "EQP_STATE", ref  message); EPT 進站 是RUN 出站後 IDLE
                        string message = string.Empty;
                        string EQPNO = FormFields["txtEQPNO".ToUpper()].Trim();
                        string lotid = "{\"Language\": \"EN\",\"LotId\": \"" + FormFields["TXTLOT".ToUpper()].Trim() + "\"}";
                        PostRelease("http://10.141.64.101:8020/MachineServiceHttp/EPT/ReleaseLot", lotid);
                        /*int date = new int();
                        bool isChangeSuccess = ReleaseLot.fwChangeState("no", "no", date,
                                                                                                                oPara.LoginId, string.Empty, "ChangeState", "DOWN", EQPNO,
                                                                                                                 "down2idle", "IDLE", "CHG_EQP_STATE", "TJ", "1", "A-AM", "EQP_STATE", ref message);

                        // ("no", "no", DataOperate.GetTimeStamp(), SessionFacade.Username, txtStateComment.Text, "ChangeState", "IDLE", eqpId, "idle2run", "RUN", "CHG_EQP_STATE", schedule, scheduleVersion, "A-AM", "EQP_STATE", ref message);
                        if (isChangeSuccess == false)
                        {
                            HandleResult.IsSuccess = false;
                            HandleResult.CustomMessage += message;
                        }*/
                    }
                    UpdateStatus(FormFields["TXTOCAPNO".ToUpper()].Trim(), "Finished", oPara.LoginId.ToString());
                }

                break;
        }

    }
    
    public override void SPMRecallProcess(SPMSubmitMethod SubmitMethod, SPMTaskVariables SPMTaskVars, SPMVariables Variables, EFFormFields FormFields, ref IInterfaceHandleResult HandleResult)
    {
        if (SubmitMethod == SPMSubmitMethod.HandleCase_Recall || SubmitMethod == SPMSubmitMethod.HandleCase_Backout)
        {
            if (!string.IsNullOrEmpty(FormFields["TXTSAPNO"].Trim()))
            {
                HandleResult.IsSuccess = false;
                HandleResult.CustomMessage += "▪SAPNO未生成无法Abort";
                return;
            }
        }

        LogWriter.writeInfo("SPMRecallProcess Abort SetMOE  CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName);
        base.SPMRecallProcess(SubmitMethod, SPMTaskVars, Variables, FormFields, ref HandleResult);
    }

    public override void SPMStepActivity(SPMSubmitMethod SubmitMethod, SPMTaskVariables SPMTaskVars, SPMVariables Variables, EFFormFields FormFields, string NewStepName, ref IInterfaceHandleResult HandleResult)
    {
        LogWriter.writeInfo("SPMStepActivity LogonID: " + oPara.LoginId + ", CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName);
        base.SPMStepActivity(SubmitMethod, SPMTaskVars, Variables, FormFields, NewStepName, ref HandleResult);
    }

    public override void SPMStepComplete(SPMSubmitMethod SubmitMethod, SPMTaskVariables SPMTaskVars, SPMVariables Variables, EFFormFields FormFields, string CompletedStepName, ref IInterfaceHandleResult HandleResult)
    {
        try
        {
            LogWriter.writeInfo("SPMStepComplete LogonID: " + oPara.LoginId + ", CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName);
        }
        catch (Exception ex)
        {
            LogWriter.writeError("SPMStepComplete LogonID: " + oPara.LoginId + ", CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName + ", ErrorMessage: " + ex.Message);
            throw new Exception(ex.Message);
        }

        base.SPMStepComplete(SubmitMethod, SPMTaskVars, Variables, FormFields, CompletedStepName, ref HandleResult);
    }

    public override void Print(int iTaskId, SPMTaskVariables SPMTaskVars, EFFormFields FormFields, object oContainer, IUIShadow UIShadow)
    {
        LogWriter.writeInfo("Print LogonID: " + oPara.LoginId + ", CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName);
    }

    public override void SPM_SendError(SPMSubmitMethod SubmitMethod, SPMTaskVariables SPMTaskVars, SPMVariables Variables, SPMRoutingVariable RoutingVariable, EFFormFields FormFields, IInterfaceHandleResult HandleResult)
    {
        LogWriter.writeInfo("SPM_SendError LogonID: " + oPara.LoginId + ", CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName);
        base.SPM_SendError(SubmitMethod, SPMTaskVars, Variables, RoutingVariable, FormFields, HandleResult);
    }

    public override void SPM_SendSuccess(SPMSubmitMethod SubmitMethod, SPMTaskVariables TaskVars, SPMVariables Variables, SPMRoutingVariable RoutingVariable, EFFormFields FormFields, System.Collections.Generic.List<SPMUser> LisNextApprover, IInterfaceHandleResult HandleResult)
    {

        if (SubmitMethod == SPMSubmitMethod.HandleCase_Recall ||
           SubmitMethod == SPMSubmitMethod.HandleCase_Backout)
        { //abort
          //if (!string.IsNullOrEmpty(FormFields["TXTSAPNO"].Trim()))
          //{
          //    HandleResult.IsSuccess = false;
          //    HandleResult.CustomMessage += "▪生成SAPNO流程无法Abort";
          //    return ;

            //}
            //else
            //{
            //    UpdateStatus(FormFields["TXTFORMNO"].Trim(), "ABORT", "A", oPara.StepName);
            //    //更新EDN状态
            //  //  UpdateStatusForEDN(FormFields["TXTGINO"].Trim(), "ABORT");
            //}

            LogWriter.writeInfo("SPM_SendSuccess Abort  CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName);
        }
        LogWriter.writeInfo("SPM_SendSuccess LogonID: " + oPara.LoginId + ", CaseID: " + oPara.CaseId + ", StepName:" + oPara.StepName);
        base.SPM_SendSuccess(SubmitMethod, TaskVars, Variables, RoutingVariable, FormFields, LisNextApprover, HandleResult);
    }

    public void PostRelease(string baseUrl, string parseData)
    {
        string result = "";
        try
        {
            //using (var client = new HttpClient)
            WebRequest ReleaseRequest = WebRequest.Create(baseUrl);
            ReleaseRequest.Method = "post";

            byte[] byteArray = Encoding.UTF8.GetBytes(parseData);
            ReleaseRequest.ContentType = "application/json";
            ReleaseRequest.ContentLength = byteArray.Length;

            System.IO.Stream dataStream = ReleaseRequest.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();

            WebResponse ReleaseResponse = ReleaseRequest.GetResponse();
        }
        catch (Exception e)
        {
            result = e.ToString();
        }
    }

    //獲取措施
    private DataTable GetCS(string strOcapno)//不用，函数调用.InitialDisableContainer用（注解掉否则元素拿掉影响），已去除调用
    {

        string sql = @"
        select  id,   case when [TYPE]='C' then '長期' else '短期'  end as TYPE , CS , CSPerson , convert(char,CSdate,111) as CSDATE  , CSFLAG    from TB_OCAPItems  where OCAPNO = @OCAPNO 
                ";
        opc.Clear();
        opc.Add(DataPara.CreateDataParameter("@OCAPNO", SqlDbType.VarChar, strOcapno));
        DataTable dt = sdb.GetDataTable(sql, opc);
        return dt;
    }
    private DataTable GetLots(string strOcapno)//用，作为BindGrd参数
    {
        string sql = @"
        select   LotID, QTY,STEP , ProductID  from TB_OCAPLOT  where OCAPNO = @OCAPNO 
                ";
        opc.Clear();
        opc.Add(DataPara.CreateDataParameter("@OCAPNO", SqlDbType.VarChar, strOcapno));
        DataTable dt = sdb.GetDataTable(sql, opc);
        return dt;
    }

    private void BindGrd(GridPanel grd, DataTable dt)//用，绑定材料追溯
    {
        if (dt.Rows.Count > 0)
        {
            grd.Store.Primary.DataSource = dt;
            grd.Store.Primary.DataBind();
        }
    }


    private void BindCS(string strOcapno)//未调用，绑措施明细的，实际是用GetSignCS方法或CSRefresh这一机制
    {
        oUIControls.storeCS.DataSource = GetCS(strOcapno);
        oUIControls.storeCS.DataBind();


    }
    private void BindSign(string Linecode, string Role)//用，下站签核人
    {
        //獲取下站簽核人
        oUIControls.storeNextStep.DataSource = GetSign(Linecode, Role);
        oUIControls.storeNextStep.DataBind();
    }
    private void BindSignToUser(string Linecode, string Step, string Logonid)//用，绑定转发下拉
    {
        //转发签核人
        oUIControls.storetouser.DataSource = GetSignTO(Linecode, Step, Logonid);//, Role
        oUIControls.storetouser.DataBind();
    }
    private void BindSignQE(string Linecode, string Role)//尚未调用，调用？，QE签核人员控件用的，不用
    {
        //獲取下站IQE
        oUIControls.storeQE.DataSource = GetSign(Linecode, Role);
        oUIControls.storeQE.DataBind();

    }
    private DataTable GetSignTO(string strlinecode, string strStep, string strLogonid)//, string strRole
    {
        string sql = @"
        SELECT name , ename FROM    TB_OCAP_ROLE  WHERE   LineCode = @Linecode and step = @Step and role in ('MFG-Leader', 'PE', 'RM') and ename <> @Logonid
                ";// union SELECT name, ename FROM TB_OCAP_ROLE WHERE LineCode = @Linecode and role = 'RM' and ename <> @Logonid
        //SELECT name, ename FROM    TB_OCAP_ROLE  WHERE   LineCode = @Linecode and step = @Step and role in ('MFG-Leader', 'PE') union SELECT name, ename FROM TB_OCAP_ROLE WHERE LineCode = @Linecode and role = 'RM'
        //select    name, ename, role  from TB_OCAP_ROLE  where Linecode = @Linecode and Step = @Step and role in ( 'MFG-Leader', 'PE', 'RM')
        opc.Clear();
        opc.Add(DataPara.CreateDataParameter("@Linecode", SqlDbType.VarChar, strlinecode));
        opc.Add(DataPara.CreateDataParameter("@Step", SqlDbType.VarChar, strStep));
        opc.Add(DataPara.CreateDataParameter("@Logonid", SqlDbType.VarChar, strLogonid));

        DataTable dts = sdb.GetDataTable(sql, opc);
        return dts;
    }

    private DataTable GetResign(string strLogonid)
    {
        string sql = @"select ename, role from tb_ocap_role where ename = @Ename";
        opc.Clear();
        opc.Add(DataPara.CreateDataParameter("@Ename", SqlDbType.VarChar, strLogonid));

        DataTable dts = sdb.GetDataTable(sql, opc);
        return dts;
    }

    private DataTable GetSign(string strLinecode, string strrole)//用,通用抓取签核人方法，依Linecode.role，确认没有要看站别
    {
        string sql = @"
        select    name, ename, role  from TB_OCAP_ROLE  where Linecode = @Linecode and role=@role
                ";

        opc.Clear();
        opc.Add(DataPara.CreateDataParameter("@Linecode", SqlDbType.VarChar, strLinecode));
        opc.Add(DataPara.CreateDataParameter("@role", SqlDbType.VarChar, strrole));

        DataTable dts = sdb.GetDataTable(sql, opc);
        return dts;
    }

    private DataTable GetSignCS(string sdatetime)//不用，措施，有调用待注解掉
    {
        string sql = @"
        select   distinct CS  , ID from TB_OCAPItems  where datetime>@datetime
                ";

        opc.Clear();
        opc.Add(DataPara.CreateDataParameter("@datetime", SqlDbType.VarChar, sdatetime));

        DataTable dts = sdb.GetDataTable(sql, opc);

        return dts;
    }



    //除非转发MFG-Leader签过后也更新
    private void UpdateMFGLeaderStatus(string ocapno, string status, string shif, string materialcheck, string IPQCCheck, string nextstepuser, string MFGLeader)//不用，已将两部分的更新移植到PE，待注解，更新status
    {
        try
        {
            sql = "update TB_OCAP_Main set S_MFGLader=@MFGLeader, MaterialCheck=@materialcheck, IPQCCheck=@IPQCCheck, Shift=@shif, statusmark=@nextstepuser , status=@STATUS,MFGLeader=@MFGLeader  where OCAPNO = @ocapno ";
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@STATUS", SqlDbType.VarChar, status));
            opc.Add(DataPara.CreateDataParameter("@nextstepuser", SqlDbType.VarChar, nextstepuser));
            opc.Add(DataPara.CreateDataParameter("@materialcheck", SqlDbType.VarChar, materialcheck));
            opc.Add(DataPara.CreateDataParameter("@IPQCCheck", SqlDbType.VarChar, IPQCCheck));
            opc.Add(DataPara.CreateDataParameter("@MFGLeader", SqlDbType.VarChar, MFGLeader));
            opc.Add(DataPara.CreateDataParameter("@shif", SqlDbType.VarChar, shif));
            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }


    private void UpdateMFGKZ(string ocapno, string MFGKZ, string statusmark)//用
    {
        try
        {
            sql = "Update  TB_OCAP_Main  set  S_MFGKZ=@MFGKZ   , statusmark=@statusmark   where OCAPNO = @ocapno ";
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@MFGKZ", SqlDbType.VarChar, MFGKZ));
            opc.Add(DataPara.CreateDataParameter("@statusmark", SqlDbType.VarChar, statusmark));
            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }

    //PE 更新状态
    private void UpdatePE(string ocapno, string status, string reason, string rootreason, string materialcheck, string shif, string PE, string statusmark)//用，待增加代码shift.status看下MFG-Leader的参数
    {
        try
        {
            sql = "update TB_OCAP_Main set   RootReason=@rootreason , Reason=@reason , MaterialCheck=@MaterialCheck , Shift=@shift , S_PE=@PE , statusmark=@statusmark , status=@status where OCAPNO = @ocapno ";//加上材料处理和问题描述(要截取资料).statusmark我加上的
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@PE", SqlDbType.VarChar, PE));
            opc.Add(DataPara.CreateDataParameter("@statusmark", SqlDbType.VarChar, statusmark));
            opc.Add(DataPara.CreateDataParameter("@reason", SqlDbType.VarChar, reason));
            opc.Add(DataPara.CreateDataParameter("@rootreason", SqlDbType.VarChar, rootreason));
            opc.Add(DataPara.CreateDataParameter("@status", SqlDbType.VarChar, status));
            opc.Add(DataPara.CreateDataParameter("@shift", SqlDbType.VarChar, shif));
            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            opc.Add(DataPara.CreateDataParameter("@MaterialCheck", SqlDbType.VarChar, materialcheck));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }


    private void PEdelitems(string ocapno)//不用，删除新增的措施明细？
    {
        try
        {
            sql = " delete   FROM  TB_OCAPItems   where OCAPNO = @ocapno ";
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }


    private void UpdatePEKZ(string ocapno, string PEKZ, string statusmark)
    {
        try
        {
            sql = "Update  TB_OCAP_Main  set  S_PEKZ=@PEKZ   , statusmark=@statusmark   where OCAPNO = @ocapno ";
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@PEKZ", SqlDbType.VarChar, PEKZ));
            opc.Add(DataPara.CreateDataParameter("@statusmark", SqlDbType.VarChar, statusmark));
            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }

    private void UpdatePEJL(string ocapno, string PEJL, string statusmark)
    {
        try
        {
            sql = "Update  TB_OCAP_Main  set  S_PEManager=@PEJL , statusmark=@statusmark   where OCAPNO = @ocapno ";
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@PEJL", SqlDbType.VarChar, PEJL));
            opc.Add(DataPara.CreateDataParameter("@statusmark", SqlDbType.VarChar, statusmark));
            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }
    
    private void UpdateQE(string ocapno, string QE, string statusmark)
    {
        try
        {
            sql = "Update  TB_OCAP_Main  set  S_QE=@QE , statusmark=@statusmark   where OCAPNO = @ocapno ";
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@QE", SqlDbType.VarChar, QE));
            opc.Add(DataPara.CreateDataParameter("@statusmark", SqlDbType.VarChar, statusmark));
            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }

    private void UpdateQECSItems(string ocapno, string IDNO, string CSFLAG)//不用，更新是否追踪措施
    {
        try
        {
            sql = "Update  TB_OCAPItems  set  CSFLAG=@CSFLAG   where OCAPNO = @ocapno  and ID=@IDNO";
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@IDNO", SqlDbType.VarChar, IDNO));
            opc.Add(DataPara.CreateDataParameter("@CSFLAG", SqlDbType.VarChar, CSFLAG));
            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }
    //看下第二个参数SQE我传了什么
    private void UpdateQECheck(string ocapno, string SQE, string IPQCYZ, string QE_Result, string QE_ResultTrack, string user)//这是更新了品质检验的相关填写，常州这只保留了材料处理参数，但是由PE去填，改PE区块调用
    {
        try
        {
            sql = "Update  TB_OCAP_Main  set  IPQCCheck=@IPQCYZ, QE_Result=@QE_Result,  QE_ResultTrack=@QE_ResultTrack,  statusmark = @user   where OCAPNO = @ocapno ";
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@IPQCYZ", SqlDbType.VarChar, IPQCYZ));
            opc.Add(DataPara.CreateDataParameter("@QE_Result", SqlDbType.VarChar, QE_Result));
            opc.Add(DataPara.CreateDataParameter("@QE_ResultTrack", SqlDbType.VarChar, QE_ResultTrack));
            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            opc.Add(DataPara.CreateDataParameter("@user", SqlDbType.VarChar, user));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }
    //JL      ,[S_QEKZ]
    //  ,[S_QEManager]

    private void UpdateQEKZ(string ocapno, string S_QEKZ, string user)//改更新RM的
    {
        try
        {
            sql = "Update  TB_OCAP_Main  set  S_RM=@S_QEKZ,   statusmark = @user   where OCAPNO = @ocapno ";//S_QEKZ
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@S_QEKZ", SqlDbType.VarChar, S_QEKZ));

            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            opc.Add(DataPara.CreateDataParameter("@user", SqlDbType.VarChar, user));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }

    private void UpdateQC(string ocapno, string S_IPQC, string user)
    {
        try
        {
            sql = "Update  TB_OCAP_Main  set  S_QC=@S_IPQC,   statusmark = @user   where OCAPNO = @ocapno ";//这原跟UpdateQEJL一样更新到S_QEManager了
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@S_IPQC", SqlDbType.VarChar, S_IPQC));
            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            opc.Add(DataPara.CreateDataParameter("@user", SqlDbType.VarChar, user));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }

    private void UpdateQEJL(string ocapno, string S_QEManager, string user)//用
    {
        try
        {
            sql = "Update  TB_OCAP_Main  set  S_QEManager=@S_QEManager,   statusmark = @user   where OCAPNO = @ocapno ";
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@S_QEManager", SqlDbType.VarChar, S_QEManager));
            opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
            opc.Add(DataPara.CreateDataParameter("@user", SqlDbType.VarChar, user));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }
    /// <summary>
    /// 更新狀態WF
    /// </summary>
    /// <param name="formNo"></param>
    /// <param name="status"></param>
    private void UpdateStatus(string ocapno, string status, string user)//用
    {
        try
        {
            sql = "update TB_OCAP_Main  set status = @STATUS, statusmark = @user where OCAPNO = @OCAPNO";
            opc.Clear();
            opc.Add(DataPara.CreateDataParameter("@STATUS", SqlDbType.VarChar, status));
            opc.Add(DataPara.CreateDataParameter("@user", SqlDbType.VarChar, user));
            opc.Add(DataPara.CreateDataParameter("@OCAPNO", SqlDbType.VarChar, ocapno));
            sdb.ExecuteNonQuery(sql, opc);
        }
        catch (Exception)
        {
            throw;
        }
    }

    /// <summary>
    /// 更新EDN Flag狀態 电子存储系统oracle数据库
    /// </summary>
    /// <param name = "DocumentNO" ></ param >
    /// < param name="flag"></param>
    private void UpdateStatusForEPT(string OCAPNO, string flag)//用
    {

        DbHelperUtility dbHelper = DBHelperFactory.CreateDbHelper("mescnnstr", ServiceName.Oracle);
        DbParameter[] parameters = new DbParameter[2];
        parameters[0] = dbHelper.DbProviderFactory.CreateParameter();
        parameters[0].DbType = DbType.String;
        parameters[0].ParameterName = "FLAG";
        parameters[0].Direction = ParameterDirection.Input;
        parameters[0].Value = flag;

        parameters[1] = dbHelper.DbProviderFactory.CreateParameter();
        parameters[1].DbType = DbType.String;
        parameters[1].ParameterName = "OCAPNO";
        parameters[1].Direction = ParameterDirection.Input;
        parameters[1].Value = OCAPNO;

        try
        {
            sql = "update    LEDWAITINGANALYZE    set  status=:FLAG  where    status = 'Active'   and  modules = 'OCAP-Inspection'  and lotno = :OCAPNO ";//:对应DbParameter
            dbHelper.ExecuteCommand(sql, parameters);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //检查状态T， 生成SAPDOC 才能签核完毕

    private DataTable GetSAPNO(string strFormno)//没调用
    {
        string sql = @"
        select   SAP_DOCNO  from TB_DeptCostMaterial_Scrap_Main  where FORMNO = @FORMNO and  Flag='T'
                ";
        opc.Clear();
        opc.Add(DataPara.CreateDataParameter("@FORMNO", SqlDbType.VarChar, strFormno));
        DataTable dt = sdb.GetDataTable(sql, opc);
        return dt;
    }

    private DataTable GetSAPNObyDocumentNO(string strDocumentNO)//没调用，目前没有的表
    {
        string sql = @"
        select   SAP_DOCNO  from TB_DeptCostMaterial_Scrap_Main  where DocumentNO = @DocumentNO 
                ";
        opc.Clear();
        opc.Add(DataPara.CreateDataParameter("@DocumentNO", SqlDbType.VarChar, strDocumentNO));
        DataTable dt = sdb.GetDataTable(sql, opc);
        return dt;
    }

    ////检查最后一站lot数量除去最后一站是否还存在
    //public DataTable CheckLotidExistsByStep(string lotid)
    //{
    //    // and  status in ('Pending', 'REJECT' )
    //    string sql = @"
    //    select   *   from TB_OCAP_Main  where  Lot = @lotid    and StatusMark    not  like 'MFG-Leader2%' and  status in ('Pending') 
    //            ";
    //    opc.Clear();
    //    opc.Add(DataPara.CreateDataParameter("@lotid", SqlDbType.VarChar, lotid));
    //    DataTable dt = sdb.GetDataTable(sql, opc);
    //    return dt;
    //}

    
    //检查最后一站除去本身号码，是否还存在，如果还有同批号在Pending或Reject就不Release，这OK？不过仔细看条件，如果其他同批号其他ocapno的只在起完单的状态status好像并非Pending
    public DataTable CheckLotidExists(string lotid, string caseid)//用
    {
        // and  status in ('Pending', 'REJECT' )
        string sql = @"
        select * from TB_OCAP_Main where Lot = @lotid and status in ('SYS', 'Pending', 'REJECT') and caseid <> @caseid
                ";
        opc.Clear();
        opc.Add(DataPara.CreateDataParameter("@lotid", SqlDbType.VarChar, lotid));
        opc.Add(DataPara.CreateDataParameter("@caseid", SqlDbType.VarChar, caseid));
        DataTable dt = sdb.GetDataTable(sql, opc);
        return dt;
    }

    //检查最后一站lot数量
    public DataTable getOCAPMain(string ocapno)//用
    {
        // and  status in ('Pending', 'REJECT' )
        string sql = @"
        select   *   from TB_OCAP_Main  where   ocapno=@ocapno  
                ";
        opc.Clear();
        opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
        DataTable dt = sdb.GetDataTable(sql, opc);
        return dt;
    }

    //以批为单位Release
    public DataTable getItemLots(string ocapno)
    {
        // and  status in ('Pending', 'REJECT' )
        string sql = @"
        select   lotid   from    TB_OCAPLOT  where     ocapno=@ocapno  
                ";
        opc.Clear();
        opc.Add(DataPara.CreateDataParameter("@ocapno", SqlDbType.VarChar, ocapno));
        DataTable dt = sdb.GetDataTable(sql, opc);
        return dt;
    }

}

public class Root
{
    public string NAME { get; set; }

    public string VALUE { get; set; }

    public string Quantity { get; set; }
}
